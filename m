Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261165AbTCJJUi>; Mon, 10 Mar 2003 04:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261191AbTCJJU3>; Mon, 10 Mar 2003 04:20:29 -0500
Received: from hera.cwi.nl ([192.16.191.8]:14322 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261208AbTCJJUU>;
	Mon, 10 Mar 2003 04:20:20 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 10 Mar 2003 10:30:23 +0100 (MET)
Message-Id: <UTC200303100930.h2A9UNo25177.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, viro@math.psu.edu
Subject: Re: Fwd: struct inode size reduction.
Cc: davej@codemonkey.org.uk, hch@infradead.org, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ha Al!
A pleasure to see you back.

> That's Wrong API(tm).
> Why do you need to keep separation between major and first minor?

In the long run things may be different, but for today it is
meaningless to have all callers pack major and minor into a dev_t
and then have this routine unpack the dev_t again.
The source gets larger, the object code gets larger, the object
code gets slower. No advantages today.

> I'd like to take a look at your CIDR for chrdev
> I've got one to resurrect and it might make sense to compare-and-merge.

Yes, maybe.

Remember my design goals. Not to make a perfect 2.8, but to give
Linux 2.6 a larger dev_t. And to do so with minimal changes -
no global restructuring - that is for 2.7 - just the minimum
to get things to work.

> I'd like to take a look

The patch on char_dev.c is a bit large, but I showed the two
essential fragments, that should be enough to see what happened.

Let me give a somewhat more explicit commented version.

Many character drivers cannot handle more than 256 minors,
so keeping the old register call and letting it mean that
one wants to register 256 minors saves lots of changes.
Only few character drivers need to be changed.

+int register_chrdev(unsigned int major, const char *name,
+                   struct file_operations *fops)
+{
+       return register_chrdev_region(major, 0, 256, name, fops);
+}

The old char_dev.c contained mysterious tty related code:
- isa_tty_dev / need_serial
- in register_chrdev the test chrdevs[major].fops != fops
- in get_chrfops the test that someone commented with
  /* Force request_module anyway, but what for? */

All this is because the same major is registered several
times in the tty code, and there was no mechanism to
specify minors. Today I see

# cat /proc/devices | head
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 vc/0
  4 vc/%d
  4 ttyS%d
  5 tty
  5 console
  5 ptmx

that majors 4 and 5 have been registered three times.

The tty code is the only code that does this, so it is
the only place where the old register_chrdev call has to
be replaced by something specifying the minor range:

@@ -2123,7 +2123,8 @@
        if (driver->flags & TTY_DRIVER_INSTALLED)
                return 0;
 
-       error = register_chrdev(driver->major, driver->name, &tty_fops);
+       error = register_chrdev_region(driver->major, driver->minor_start,
+                                      driver->num, driver->name, &tty_fops);
        if (error < 0)
                return error;
        else if(driver->major == 0)

Then the registration has to store some stuff

+static struct char_device_struct {
+       struct char_device_struct *next;
+       unsigned int major;
+       unsigned int baseminor;
+       int minorct;
+       const char *name;
+       struct file_operations *fops;
+} *chrdevs[MAX_PROBE_HASH];

where the index in the hash is simply done by

+static inline int major_to_index(int major)
{
+       return major % MAX_PROBE_HASH;
 }

with completely arbitrary MAX_PROBE_HASH - it could be 1.

+#define MAX_PROBE_HASH 255     /* random */

and the getfops must check minor

static struct file_operations *
lookup_chrfops(unsigned int major, unsigned int minor)
{
        struct char_device_struct *cd;
        struct file_operations *ret = NULL;
        int i;

        i = major_to_index(major);

        read_lock(&chrdevs_lock);
        for (cd = chrdevs[i]; cd; cd = cd->next) {
                if (major == cd->major &&
                    minor - cd->baseminor < cd->minorct) {
                        ret = fops_get(cd->fops);
                        break;
                }
        }
        read_unlock(&chrdevs_lock);

        return ret;
}

static struct file_operations *
get_chrfops(unsigned int major, unsigned int minor)
{
        struct file_operations *ret = NULL;

        if (!major)
                return NULL;

        ret = lookup_chrfops(major, minor);

#ifdef CONFIG_KMOD
        if (!ret) {
                char name[32];
                sprintf(name, "char-major-%d", major);
                request_module(name);

                ret = lookup_chrfops(major, minor);
        }
#endif
        return ret;
}

Finally the more-or-less obvious register_chrdev_region.
That is about it.

Result: no more occurrences of MAX_BLKDEV and MAX_CHRDEV
in the kernel source. There are a few other minor things
to polish, and then the type of dev_t can be changed.

This is getting a bit long, so let me continue in another letter.

Andries

