Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTKTWta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 17:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTKTWta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 17:49:30 -0500
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:44526 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262790AbTKTWt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:49:28 -0500
Date: Thu, 20 Nov 2003 15:44:55 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Jesse Pollard <jesse@cats-chateau.net>, Florian Weimer <fw@deneb.enyo.de>,
       Valdis.Kletnieks@vt.edu, Daniel Gryniewicz <dang@fprintf.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031120154454.K20568@schatzie.adilger.int>
Mail-Followup-To: Xavier Bestel <xavier.bestel@free.fr>,
	Jesse Pollard <jesse@cats-chateau.net>,
	Florian Weimer <fw@deneb.enyo.de>, Valdis.Kletnieks@vt.edu,
	Daniel Gryniewicz <dang@fprintf.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1068512710.722.161.camel@cube> <03111209360001.11900@tabby> <20031120172143.GA7390@deneb.enyo.de> <03112013081700.27566@tabby> <1069367504.8945.55.camel@bip.parateam.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1069367504.8945.55.camel@bip.parateam.prv>; from xavier.bestel@free.fr on Thu, Nov 20, 2003 at 11:31:45PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20, 2003  23:31 +0100, Xavier Bestel wrote:
> Le jeu 20/11/2003 à 20:08, Jesse Pollard a écrit :
> > 1. what happens if the copy is aborted?

Same as now with "cp" - partial copy.

> > 2. what happens if the network drops while the remote server continues?

Irrelevant, since you can't access the file at that point (i.e. if server
continues then great, but if it doesn't it's no different than the server
disconnecting/crashing in the middle of a regular copy.

> > 3. what about buffer synchronization?

Sync file locally before starting, and no buffers on client are created.
If you write to file while it is being copied, how is that different
than two writers for same file now (i.e. usually broken).  If the network
filesystem doesn't support locking, that's the filesystem's problem and
this API doesn't change it.

> > 4. what errors should be reported ?

Covered pretty well elsewhere.  Of course EINTR should be reserved for
"interrupted, please continue if you want" as opposed to a hard error.

> > 5. what happens when the syscall is interupted? Especially if the remote
> >    copy may take a while (I've seen some require an hour or more - worst
> >    case: days due to a media error (completed after the disk was replaced)).

Partial copy, no different than now.

> > 6. what about a client opening the copy before it is finished copying?

Reads partial file, no different than now.

> 7. How to report progress with your average file manager ?

Support signals and restart the copy where it left off.  Interrupting
once a second or whatever isn't onerous if needed and you can restart.
You could even support some sort of "SIGUSR1" like dd does to get status
back without actually killing things.  Alternately, just stat the target
file as it is being copied to watch progress.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

