Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWCZRLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWCZRLg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWCZRLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:11:36 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:24232 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751262AbWCZRLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:11:35 -0500
Message-ID: <4426CB05.2070604@cfl.rr.com>
Date: Sun, 26 Mar 2006 12:10:29 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Michael Halcrow <lkml@halcrow.us>
CC: Michael Halcrow <mhalcrow@us.ibm.com>, akpm@osdl.org,
       phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk,
       mcthomps@us.ibm.com, yoder1@us.ibm.com, toml@us.ibm.com,
       emilyr@us.ibm.com, daw@cs.ber
Subject: Re: eCryptfs Design Document
References: <20060324222517.GA13688@us.ibm.com> <442599D5.806@cfl.rr.com> <20060325195015.GA8174@halcrow.us>
In-Reply-To: <20060325195015.GA8174@halcrow.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow wrote:
> The mount-wide passphrase in the user session keyring is actually not
> necessary to keep around after the mount process is finished in this
> release, and we will likely alter the design and implementation for
> the 0.1 release to just remove it once the file key encryption key is
> associated with the eCryptfs superblock object on mount.
> 

I see, so for now you import the key from the keyring into the 
superblock at mount time, but in the future you will directly use the 
key from the keyring as needed?

> In future releases, we will be storing multiple passphrase and public
> key authentication tokens in the user's eCryptfs keyring, and so the
> use of the kernel keyring will make a lot more sense. We are trying to
> make things as simple as possible for the 0.1 release so as to limit
> the complexity involved in analysis and debugging.
> 
>> Are you saying that you salt the passphrase, hash that, then hash
>> the hash, then hash that hash, and so on?  What good does repeatedly
>> hashing the hash do?  Simply hashing the salted passphrase should be
>> sufficient to obtain a key.
> 
> This approach is only used to help make dictionary attacks against the
> passphrase a bit harder.
> 

Isn't that what adding the salt is for?  You add 16 bits of salt so that 
a pre hashed dictionary would require 65,536 different hashes per 
passphrase permutation.  That places more computation burden on 
generating such a dictionary, but more importantly it places a large 
storage burden on the dictionary.

Recursively hashing only places greater computation on the creation of 
the dictionary, which is of no consequence as the dictionary only has to 
be created once.  If you want to fight dictionary attacks, you should 
add a longer salt rather than recursively hash.  Taking the salt from 16 
bits to 32 bits also requires the attacker to compute 65,536 times more 
hashes per passphrase permutation at dictionary creation time, but ALSO 
requires that they store 65,536 times more hashed values in the dictionary.

Another thought that crossed my mind is that it is likely possible to 
factor the recursive hash function and simplify it such that it can be 
computed almost as quickly as the single hash rather than taking 65,536 
times longer.

