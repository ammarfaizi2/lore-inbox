Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269366AbUIYROA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269366AbUIYROA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 13:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269367AbUIYROA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 13:14:00 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:64727 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S269366AbUIYRNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 13:13:34 -0400
Message-ID: <4155A7C9.4040606@myrealbox.com>
Date: Sat, 25 Sep 2004 10:15:53 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: David Lang <david.lang@digitalinsight.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
References: <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <Pine.LNX.4.60.0409241819580.1341@dlang.diginsite.com> <20040925013013.GD3309@dualathlon.random> <200409250147.i8P1kxtm016914@turing-police.cc.vt.edu> <20040925021501.GF3309@dualathlon.random> <200409250246.i8P2kWwx027390@turing-police.cc.vt.edu>            <20040925025848.GG3309@dualathlon.random> <200409250329.i8P3TwJY002358@turing-police.cc.vt.edu>
In-Reply-To: <200409250329.i8P3TwJY002358@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Sat, 25 Sep 2004 04:58:48 +0200, Andrea Arcangeli said:
> 
> 
>>I don't even think "save their key securely" (I mean saving anything
>>related to the swapsuspend encryption key on disk) is needed. A mixture
>>of a on-disk key + passphrase would not be more secure than a simple
>>"passphrase" alone, because the on-disk key would be in cleartext and
>>readable from the attacker. the only usable key is the one in the user memory,
>>it cannot be saved in the computer anywhere. Peraphs for additional
>>security (and to avoid having to type and remember it) one could use an
>>usb pen to store and fetch the key... but then I leave the fun to the
>>usb folks since to do that usb should kick off before resume overwrites
>>the kernel image ;)
> 
> 
> Well, obviously saving the actual key on the disk is a losing idea, but saving
> "key hashed by passphrase" would work (similar to how PGP or SSH don't save the
> actual key, but rather the key hashed by something).
> 
> I suspect that having the *entire* key be the passphrase remembered by the user
> is also a non-starter security-wise (unless we do something like Jari Ruusu's
> loop-AES stuff does and forces a minimim 20-char passphrase) - there's going to
> be all too many blocks in the swsusp area that are "known plaintext" and easily
> brute-forceable for most passphrases that users are likely to actually use.
> 
> So in order to make it at all secure, we really need to save on the disk
> a key with O(128 bits) of entropy, perturbed by enough bits that are *not*
> to be found anywhere on the machine so that it isn't a slam-dunk for an attacker.
> 
> Do any of the crypto experts lurking have ideas/opinions on just how many
> bits we need to store externally (be it in a USB dongle, a thumbprint, a
> passphrase, whatever)?
> 

Not really a crypto expert, but...  use a random session key, at least 
128 bits.  Encrypt _that_ with the passphrase or whatever, eliminating 
any known plaintext.  Since this decryption is only done once at bootup, 
we don't care how slow it may be, so use an iterated scheme (like 
Blowfish crypt).  That way the user could dial it to take 500ms or so on 
the local machine to try a passphrase, making weak passphrases a lot 
harder to bruteforce.  Or the kernel should iteratively encrypt it at 
suspend for some fixed time, then store the iteration count.

So long as suspend/resume is supported, there's a risk that someone 
captures a suspended system and steals a disk image.  Later they force 
the owner to reveal the passphrase.  Now they can see not only the 
useful contents of memory but any old stuff that's been sitting in swap 
since the last reboot (like PGP keys).  This could be avoided by making 
the system somewhat forward-secret: generate a random key per vma and 
zero it out of RAM when the vma goes away (assuming the vma is the right 
unit for it).  If the IVs are chosen based on position in the swap 
device then there should be very little overhead.

--Andy
