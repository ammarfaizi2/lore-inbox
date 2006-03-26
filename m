Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWCZSK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWCZSK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 13:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWCZSKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 13:10:25 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:24998 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S932210AbWCZSKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 13:10:23 -0500
X-ORBL: [70.129.201.140]
Date: Sun, 26 Mar 2006 12:04:58 -0600
From: Michael Halcrow <lkml@halcrow.us>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Michael Halcrow <mhalcrow@us.ibm.com>, akpm@osdl.org,
       phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk,
       mcthomps@us.ibm.com, yoder1@us.ibm.com, toml@us.ibm.com,
       emilyr@us.ibm.com, daw@cs.ber
Subject: Re: eCryptfs Design Document
Message-ID: <20060326180458.GA10056@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
References: <20060324222517.GA13688@us.ibm.com> <442599D5.806@cfl.rr.com> <20060325195015.GA8174@halcrow.us> <4426CB05.2070604@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4426CB05.2070604@cfl.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 12:10:29PM -0500, Phillip Susi wrote:
> Michael Halcrow wrote:
> >The mount-wide passphrase in the user session keyring is actually
> >not necessary to keep around after the mount process is finished in
> >this release, and we will likely alter the design and
> >implementation for the 0.1 release to just remove it once the file
> >key encryption key is associated with the eCryptfs superblock
> >object on mount.
> 
> I see, so for now you import the key from the keyring into the
> superblock at mount time, but in the future you will directly use
> the key from the keyring as needed?

Yes. Since that's going to be ``in the future,'' it makes sense just
to remove it from the keyring after the mount is complete for now.

> >>Are you saying that you salt the passphrase, hash that, then hash
> >>the hash, then hash that hash, and so on?  What good does repeatedly
> >>hashing the hash do?  Simply hashing the salted passphrase should be
> >>sufficient to obtain a key.
> >
> >This approach is only used to help make dictionary attacks against the
> >passphrase a bit harder.
> 
> Isn't that what adding the salt is for?  You add 16 bits of salt so that 
> a pre hashed dictionary would require 65,536 different hashes per 
> passphrase permutation.

The salt in eCryptfs is 64 bits (8 octets, per the spec of the
iterated and salted S2K; see Section 3.6.1.3 RFC 2440). Without the
iterated hashing, the raw dictionary generation will require storage
on the scale of 2^64 multiplied by the size of the dictionary. I think
this is big enough to address any attacks that involve pre-computed
dictionaries, as you have already pointed out.

The dictionary attack that I have in mind that I would like to make a
``bit'' harder is the dedicated attack against one particular file. If
an attacker just wants to attack the passphrase on that file, then
without iterated hashing, the difficulty is roughly proportional (in
aggregate) to half size of the dictionary. If the passphrase is weak,
then the file will likely be compromised anyway, but at least an
iterated hash multiplies the amount of work that the dictionary
attacker needs to do by the number of iterations.

The question then is whether the additional hashing effort on the part
of a legitimate user has a good cost/benefit security tradeoff. If the
passphrase is strong and if the user is having to do the iterated hash
on every file in a large directory, then the tradeoff is probably
bad. If the passphrase is weak, the user can tolerate the overhead of
iterated hashing on file opens, and the attacker has limited
computational resources, then the tradeoff might be good. Ultimately,
that is the sort of thing I would like to be configurable via policy
in later versions of eCryptfs.

Keep in mind that, for the current release of eCryptfs, the iterated
hashing only happens once per mount, not once per file, and so there
is very little cost to the user, and it has at least some security
benefit, so why not do it? Note that this will change in later
versions, as a different salt is generated for each file in the
system, but it will also be configurable in later versions.

Mike
