Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272396AbTHEDMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 23:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272397AbTHEDMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 23:12:34 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:13788 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S272396AbTHEDMS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 23:12:18 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Date: Tue, 5 Aug 2003 13:11:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown
Content-Transfer-Encoding: 8BIT
Message-ID: <16175.8310.467301.229049@gargle.gargle.HOWL>
Cc: herbert@13thfloor.at, beepy@netapp.com, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
In-Reply-To: message from Stephan von Krawczynski on Monday August 4
References: <20030804134415.GA4454@win.tue.nl>
	<200308041542.h74Fg9k26251@orbit-fe.eng.netapp.com>
	<20030804175609.7301d075.skraw@ithnet.com>
	<20030804161657.GA6292@www.13thfloor.at>
	<20030804183545.01b7a126.skraw@ithnet.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday August 4, skraw@ithnet.com wrote:
> On Mon, 4 Aug 2003 18:16:57 +0200
> Herbert Pötzl <herbert@13thfloor.at> wrote:
> 
> > on the other hand, if you want somebody to implement
> > this stuff for you, you'll have to provide convincing
> > arguments for it, I for example, would be glad if
> > hardlinks where removed from unix altogether ...
> 
> Huh, hard stuff!
> 
> Explain your solution for a very common problem:
> 
> You have a _big_ fileserver, say some SAN or the like with Gigs.
> Your data on it is organized according to your basic user structure, because it
> is very handy to have all data from one user altogether in one directory.
> You have lots of hosts that use parts of the users' data for a wide range of
> purposes, lets say web, ftp, sql, name one.
> If you cannot re-structure and export your data according to the requirements
> of your external hosts (web-trees to webserver, sql-trees to sql-server,
> ftp-trees to ftp-server, name-it to cool-server) you will have to export the
> total user tree to all your (cluster-) nodes. Do you want that? NO! Of course
> you don't want that in times of hacked webservers and uncontrollable
> sql-servers. If anything blows up you likely loose all data at once. On the
> other hand, if you managed to link all web-data together in one directory and
> exported that to your webservers and they are hacked, you just blew up all your
> web-data but nothing more. This is a remarkable risk reduction.
> And now? Name your idea to export only the data needed to the servers that need
> it. And keep in mind, we are talking of Gigs and tenthousands of users. You
> definitely don't want one mount per user per service.
> Can you think of a more elegant way to solve such a problem than hardlinking
> all web in one single webtree, all sql in one single sql tree ... and then
> export this single tree (with its artificial structure) to the corresponding
> server?
> I am curiously listening...

I would suggest that this is where you should have started.
Instead of leading people down pointless discussions about hardlinks
to directories, it would be best to state the real problem.  The best
solution almost certainly has nothing to do with hardlinks to
directories (which are simply *not* Unix).

What you want to do, it would seem, is
  1/ nfs-export just selected subtrees of users' accounts to selected
  servers and
  2/ mount just those sub-trees on the relevant servers.

Neither of these are particularly difficult except from an admin
perspective.
For (1) just put lines like:

    /home/neilb/public_html webserver(rw)
    /home/neilb/public_ftp ftpserver(rw)
    /home/neilb/database   dbserver(rw)

    /home/fred/public_html webserver(rw)
    ...

in /etc/exports and it is done.

for 2, just use an automounter with a different map on each server.

For the straight-forward approach you would need to modifiy
/etc/exports and all the maps whenever you add a new user. which isn't
ideal from an admin perspective.

We do the second of these on our cgi-servers, but we have a
sophisticated user database that can present arbitrary views as NIS
maps, and we point amd at an appropiate NIS map and it sees new users
as they are added.  You would need to integrate management of the
automounter maps with whatever accounts management system you have.

We don't bother with the second (I'm not worried about root compomises
much - I'm just worried that if someone installs an insecure cgi
script, an attacker cannot get beyond that person's public_html) but if
I did, it would not be hard to modify nfs_utils to understand
wildcards in /etc/exports so that, e.g.
 
    /home/*/public_html webserver(rw)

would be equivalent to as whole list of similar lines with explicit
user names.
I might even do that for an upcoming release of nfs-utils, but no
promises.

In summary: you cannot "hardlink directories"(*) and if you think you
want to, you are probably asking the wrong question.

NeilBrown

(*) I put "hardlink directories" in quotes because ofcourse you can
have hard links to directories.  Every  child has a hard link called
".." and the one parent has a hard link with some other name.
What you really mean in "multiple parents of directories" and that is
not possible for assorted reasons, but mostly because you cannot have
multiple ".."s.
