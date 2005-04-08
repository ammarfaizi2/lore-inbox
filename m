Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVDHHXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVDHHXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 03:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVDHHXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:23:13 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15185
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262718AbVDHHU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:20:56 -0400
Date: Fri, 8 Apr 2005 09:14:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050408071428.GB3957@opteron.random>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050408041341.GA8720@taniwha.stupidest.org> <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 09:42:04PM -0700, Linus Torvalds wrote:
> play with something _really_ nasty (but also very _very_ fast), take a
> look at kernel.org:/pub/linux/kernel/people/torvalds/.

Why not to use sql as backend instead of the tree of directories? That solves
userland journaling too (really one still has to be careful to know the
read-committed semantics of sql, which is not obvious stuff, but 99% of
common cases like this one just works safe automatically since all
inserts/delete/update are always atomic).

You can keep the design of your db exactly the same and even the command line
of your script the same, except you won't have deal with the implementation of
it anymore, and the end result may run even faster with proper btrees and you
won't have scalability issues if the directory of hashes fills up, and it'll
get userland journaling, live backups, runtime analyses of your queries with
genetic algorithms (pgsql 8 seems to have it) etc...

I seem to recall there's a way to do delayed commits too, so you won't
be sychronous, but you'll still have journaling. You clearly don't care
to do synchronous writes, all you care about is that the commit is
either committed completely or not committed at all (i.e. not an half
write of the patch that leaves your db corrupt).

Example:

CREATE TABLE patches (
	patch			BIGSERIAL	PRIMARY KEY,

	commiter_name		VARCHAR(32)	NOT NULL CHECK(commiter_name != ''),
	commiter_email		VARCHAR(32)	NOT NULL CHECK(commiter_email != ''),

	md5			CHAR(32)	NOT NULL CHECK(md5 != ''),
	len			INTEGER		NOT NULL CHECK(len > 0),
	UNIQUE(md5, len),

	payload			BYTEA		NOT NULL,

	timestamp		TIMESTAMP	NOT NULL
);
CREATE INDEX patches_md5_index ON patches (md5);
CREATE INDEX patches_timestamp_index ON patches (timestamp);

s/md5/sha1/, no difference.

This will automatically spawn fatal errors if there are hash collisions and it
enforces a bit of checking.

Then you need a few lines of python to insert/lookup. Example for psycopg2:

import pwd, os, socket

[..]

patch = {'commiter_name': pwd.getpwuid(os.getuid())[4],
         'commiter_email': pwd.getpwuid(os.getuid())[0] + '@' + socket.getfqdn(),
	 'md5' : md5.new(data).hexdigest(), 'len' : len(data),
	 payload : data, 'timestamp' : 'now'}
curs.execute("""INSERT INTO patches
                  VALUES (%(committer_name)s, %(commiter_email)s, 
	          %(md5)s, %(len)s, %(payload)s, %(timestamp)s)""", patch)

('now' will be evaluated by the sql server, who knows about the time too)

The speed I don't know for sure, but especially with lots of data the sql way
should at least not be significantly slower, pgsql scales with terabytes
without apparent problems (modulo the annoyance of running vacuum once per day
in cron, to avoid internal sequence number overflows after >4 giga
committs, and once per day the analyser too so it learns about your
usage patterns and can optimize the disk format for it).

For sure the python part isn't going to be noticeable, you can still write it
in C if you prefer (it'll clearly run faster if you want to run tons of
inserts for a benchmark), so then everything will run at bare-hardware
speed and there will be no time wasted interpreting bytecode (only the
sql commands have to be interpreted).

The backup should also be tiny (runtime size is going to be somewhat larger due
the more data structure it has, how much larger I don't know). I know for sure
this kind of setup works like a charm on ppc64 (32bit userland), and x86 (32bit
and 64bit userland).

monotone using sqlite sounds a good idea infact (IMHO they could use a real
dbms too, so that you also get parallelism and you could attach another app to
the backing store at the same time or you could run a live backup and to
get all other high end performance features).

If you feel this is too bloated feel free to ignore this email of course! If
instead you'd like to give this a spin, let me know and I can help to
set it up quick (either today or from Monday).

I also like quick dedicated solutions and I was about to write a backing
store with a tree of dirs + hashes similar to yours for a similar
problem, but I give it up while planning the userland journaling part
and even worse the userland fs locking with live backups, when a DBMS
gets everything right including live backups (and it provides async
interface too via sockets). OTOH for this usage journaling and locking
aren't a big issue since you may have the patch to hash by hand to find
any potentially half-corrupted bit after reboot and you probably run it
serially.

About your compression of the data, I don't think you want to do that.
The size of the live image isn't the issue, the issue is the size of the
_backups_ and you want to compress an huge thing (i.e. the tarball of
the cleartext, or the sql cleartext backup), not many tiny patches.

Comparing the size of the repositories isn't interesting, the
interesting thing is to compare the size of the backups.

BTW, this fixed compliation for my system.

--- ./Makefile.orig	2005-04-08 09:07:17.000000000 +0200
+++ ./Makefile	2005-04-08 08:52:35.000000000 +0200
@@ -8,7 +8,7 @@ all: $(PROG)
 install: $(PROG)
 	install $(PROG) $(HOME)/bin/
 
-LIBS= -lssl
+LIBS= -lssl -lz
 
 init-db: init-db.o
 

Thanks.
