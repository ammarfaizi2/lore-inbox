Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWCYTzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWCYTzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 14:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWCYTzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 14:55:25 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:42471 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751128AbWCYTzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 14:55:24 -0500
X-ORBL: [70.129.201.140]
Date: Sat, 25 Mar 2006 13:50:15 -0600
From: Michael Halcrow <lkml@halcrow.us>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Michael Halcrow <mhalcrow@us.ibm.com>, akpm@osdl.org,
       phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk,
       mcthomps@us.ibm.com, yoder1@us.ibm.com, toml@us.ibm.com,
       emilyr@us.ibm.com, daw@cs.berk
Subject: Re: eCryptfs Design Document
Message-ID: <20060325195015.GA8174@halcrow.us>
Reply-To: Michael Halcrow <lkml@halcrow.us>
References: <20060324222517.GA13688@us.ibm.com> <442599D5.806@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442599D5.806@cfl.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 02:28:21PM -0500, Phillip Susi wrote:
> Michael Halcrow wrote:
> >* A mount-wide passphrase is stored in the user session 
> >  keyring in the form of an authentication token.
> 
> You say several times that a mount-wide passphrase is used for the
> master key.  If that is the case, then it would be given at mount
> time and be bound to the super block.

The mount-wide passphrase in the user session keyring is actually not
necessary to keep around after the mount process is finished in this
release, and we will likely alter the design and implementation for
the 0.1 release to just remove it once the file key encryption key is
associated with the eCryptfs superblock object on mount.

In future releases, we will be storing multiple passphrase and public
key authentication tokens in the user's eCryptfs keyring, and so the
use of the kernel keyring will make a lot more sense. We are trying to
make things as simple as possible for the 0.1 release so as to limit
the complexity involved in analysis and debugging.

For the record, if you mount with one passphrase, create a file,
unmount, mount with another passphrase, and create another file, then
you will have two files side-by-side that are only accessible with
their respective passphrases. To access the first file, you need to
mount with the passphrase used to create that file in the first place,
and to access the second file, you need to mount with the passphrase
used to create that file. In future releases, the idea is that the
user will have two authentication tokens in the keyring, one for each
passphrase, so that he will be able to access either file under the
same mount.

> >passphrase into a key follows the S2K process as described in RFC
> >2440, in that the passphrase is concatenated with a salt; that data
> >block is then iteratively MD5-hashed 65,536 times to generate the key
> >that encrypts the file encryption key.
> 
> Are you saying that you salt the passphrase, hash that, then hash
> the hash, then hash that hash, and so on?  What good does repeatedly
> hashing the hash do?  Simply hashing the salted passphrase should be
> sufficient to obtain a key.

This approach is only used to help make dictionary attacks against the
passphrase a bit harder.

Mike
