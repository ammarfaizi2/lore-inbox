Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTJBKId (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 06:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbTJBKId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 06:08:33 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:14473 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263320AbTJBKI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 06:08:29 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16251.63770.622805.143036@laputa.namesys.com>
Date: Thu, 2 Oct 2003 14:08:26 +0400
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Zan Lynx <zlynx@acm.org>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: 2.6.0-test6 crash while reading files in /proc/fs/reiserfs/sda1
In-Reply-To: <20031001184338.GW7665@parcelfarce.linux.theplanet.co.uk>
References: <1064936688.4222.14.camel@localhost.localdomain>
	<200309302006.32584.vitaly@namesys.com>
	<1065019441.4226.1.camel@localhost.localdomain>
	<16251.5348.570797.101912@laputa.namesys.com>
	<20031001184338.GW7665@parcelfarce.linux.theplanet.co.uk>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk writes:
 > On Wed, Oct 01, 2003 at 09:54:44PM +0400, Nikita Danilov wrote:
 >  
 > > Cannot help but describe a little detail: r_stop() erroneously thought
 > > that de->data contains a pointer to the super block, while in reality
 > > address of some fs/reiserfs/procfs.c:show_* function was stored
 > > there. As a result, deactivate_super() danced fine fandango on core, in
 > > particular, in the case of show_oidmap() it modified first assignment
 > > within loop to reset loop counter back to zero.
 > 
 > *Ouch*

There are few other things that bother me:

1. r_start() call sget() and this seems somewhat expensive (sget()
starts by allocating new super block just for case) to be done at the
beginning of each read operation, especially given that we already have
pointer to the super block. Probably slook() function that only looks
for the super block without creating it would be useful.

2. More importantly, sget() doesn't actually seem to provide protection
against races with umount (which I think is its purpose): test_sb
callback will succeed for any super block with the same *address*, which
may be (and will be, given slab allocator) some completely unrelated
super block that just happened to be allocated at the same address as
(already freed) de->parent->data. Roughly speaking, super block in
de->parent->data is untrusted pointer and, as such, is almost completely
useless.

This is why original fs/reiserfs/procfs.c code stored dev_t in proc
entry and played unholy games with it: if we look super block up by
dev_t and then check that it is actually reiserfs super block, races
with umount are not important.

This seems to display deeper problem: VFS has no idea that files in
/proc/fs/reiserfs/<devname> (or /sys/fs/reiser4/<devname>) are related
to the file system mounted at /<mountpoint> and, hence, provide no
synchronization.

What about creating fake struct vfsmount for /proc/fs/reiserfs/<devname>
and attaching it to the super block of /<mountpoint>? After all
/proc/fs/reiserfs/<devname> is just a view into /<mountpoint>. This will
automatically guarantee that /<mountpoint> cannot be unmounted while
files in /proc/fs/reiserfs/<devname> are opened. Will this screw up
dcache?

 > 
 > Thanks for spotting.  IMO there's an easier fix, though - I see what you
 > do with ERR_PTR() and it's a clever way to pass information, but it would
 > be much more straightforward to have the following:
 > 
 > r_start() - as now
 > 
 > static void *r_next(struct seq_file *m, void *v, loff_t *pos)
 > {
 > 	++*pos;
 > 	if (v)
 > 		deactivate_super(v);
 > 	return NULL;
 > }
 > 
 > static void r_stop(struct seq_file *m, void *v)
 > {
 > 	if (v)
 > 		deactivate_super(v);
 > }
 > 
 > r_show() - as now.
 > 
 > We don't need to crawl in de->... guts past that point in ->start() - after
 > all, past that point we'll have a pointer to our superblock passed as argument.

Yes, possible. I had similar problem in reiser4 also: for some seq_file,
x_start() allocated some data structure (struct x_struct) that is used
by x_next(), x_show(), and is deallocated in x_stop(). As x_struct is
per read invocation rather than per file it cannot be stored in seq_file
itself. I had to resort to returning x_struct from x_start() and passing
it without change through x_next()'s. Thing actually changed by x_next()
was embedded in x_struct. Last x_next() had to deallocate x_struct and
to return NULL (much like your example above).

What about changing seq_file interface to allow passing additional data
like:

struct seq_operations {
	void * (*start) (struct seq_file *m, void **ctx, loff_t *pos);
	void (*stop) (struct seq_file *m, void *ctx, void *v);
	void * (*next) (struct seq_file *m, void *ctx, void *v, loff_t *pos);
	int (*show) (struct seq_file *m, void *ctx, void *v);
};

Or may be

struct seq_context {
   void *v; /* this is changed by ->next() */
   loff_t pos; /* current position */
   void *ctx; /* for private use */
};

struct seq_operations {
	int  (*start) (struct seq_file *m, struct seq_context *ctx);
	void (*stop) (struct seq_file *m, struct seq_context *ctx);
	int  (*next) (struct seq_file *m, struct seq_context *ctx);
	int  (*show) (struct seq_file *m, struct seq_context *ctx);
};

In the latter case all methods return error codes or 0 for
success. ->next() returns 0 for stop or >0 for continue.

Nikita.
