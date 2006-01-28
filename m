Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWA1KrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWA1KrI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 05:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWA1KrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 05:47:08 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:19349 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S932186AbWA1KrH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 05:47:07 -0500
Date: Sat, 28 Jan 2006 11:46:11 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Subject: Re: [PATCH 01/04] Add multi-precision-integer maths library
Message-ID: <20060128104611.GA4348@hardeman.nu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	David Howells <dhowells@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	keyrings@linux-nfs.org
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <20060128002241.GD3777@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <20060128002241.GD3777@stusta.de>
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 01:22:41AM +0100, Adrian Bunk wrote:
>On Fri, Jan 27, 2006 at 09:41:58PM +0100, David Härdeman wrote:
>> The reason that I wanted DSA-keys supported by the in-kernel key stuff 
>> is that it allows for some cool stuff which is either impossible or very 
>> hard to do otherwise.
>> 
>> For example, a backup daemon which wishes to store the backup on another 
>> host using ssh. Usually this is solved by storing an unencrypted key in 
>> the fs or by providing a connection to a ssh-agent which has been 
>> preloaded with the proper key(s). Both are quite inelegant solutions. 
>> With the in-kernel support, the daemon can request the key using the 
>> request_key call, and (provided proper scripts are written), the user 
>> who controls the relevant key can supply it. This in turn means that the 
>> backup daemon can sign using the key and read its public parts but not 
>> the private key.
>
>What exactly is the unsolvable problem with doing this in userspace?

See below

>> So yes, that is one example of doing "something" with keys that the 
>> process is not allowed to retrieve directly (the key itself could be 
>> supplied from removable storage or something and given a few minutes of 
>> time-to-live).
>> 
>> It also means that users would not have to run ssh-agent and would not 
>> have to bother with making sure that only one instance of ssh-agent is 
>> running even if they are logged in multiple times.
>> 
>> The in-kernel key management also protects the key against many of the 
>> different ways in which a user-space daemon could be attacked (ptrace, 
>> swap-out, coredump, etc).
>
>If an attacker has enough privileges for attacking the daemon, he should 
>usually also have enough privileges for attacking the kernel.

Not necessarily, if you have your ssh-keys in ssh-agent, a compromise of 
your account (forgot to lock the screen while going to the bathroom? 
did the OOM-condition occur which killed the program which locks the
screen? remote compromise of the system? local compromise?) means that a large 
array of attacks are possible against the daemon.

In addition, as stated before, the "backup" account, or whatever user the 
daemon which wants to sign stuff with your key is running as, might be 
compromised.

Currently, if you want to give the daemon access to the keys via 
ssh-agent (or something similar), you have to change the permissions on 
the ssh-agent socket to be much less restricted (especially since it's 
unlikely that you have permission to change the uid or gid of the socket 
to that of the daemon). Alternatively you can provide the backup daemon 
with the key directly (via fs, or loaded somehow at startup...etc), but 
then a compromise of the daemon means that the attacker has the private 
key.

Finally, the in-kernel system also provides a mechanism for the daemon 
to request the key when it is needed should it realize that the proper 
key is missing/has changed/whatever.

>The number of different attacks might be lower, but you haven't 
>completely solved any problem.

Many of the problems are unsolveable without having specialized hardware 
(i.e. a smartcard). The fact that the dsa patch is not a panacea does 
not mean that it can't, or that we shouldn't strive to, improve upon the 
current situation

>> In addition, the dsa key code can be used to implement signed binaries 
>> and signed modules.
>>...
>
>Checking signatures on modules sounds like a job for module-init-tools
>(if there's any real benefit in signing GPL'ed modules).

No, not really, take a look at http://lwn.net/Articles/92617/ for 
details of how signed modules could work (public key is merged into 
kernel at build time, private key is used to build modules with embedded 
signature, kernel checks module sigs at load-time using the embedded public 
key, so checks can't be in module-init-tools).

Regards,
David
