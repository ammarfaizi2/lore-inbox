Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbUJXU7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbUJXU7K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 16:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbUJXU7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 16:59:10 -0400
Received: from gprs214-148.eurotel.cz ([160.218.214.148]:4482 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261622AbUJXU7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 16:59:04 -0400
Date: Sun, 24 Oct 2004 22:58:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>
Subject: Re: Totally broken PCI PM calls
Message-ID: <20041024205841.GH28314@elf.ucw.cz>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102115410.3897@ppc970.osdl.org> <20041011101824.GC26677@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0410110857180.3897@ppc970.osdl.org> <20041015135955.GD2015@elf.ucw.cz> <Pine.LNX.4.58.0410150839010.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410150839010.3897@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm trying to learn how to work with bitwise on obsolete stuff, but
> > checking there is good, too, right?
> > 
> > Is this right way to do it?
> > 
> > +typedef enum pm_request __bitwise {
> > +       __bitwise PM_SUSPEND, /* enter D1-D3 */
> > +       __bitwise PM_RESUME,  /* enter D0 */
> > +} pm_request_t;
> 
> No, "__bitwise" is a type attribute, so you'd have to do it something like 
> this:

Ok, after -Wbitwise for sparse, strict typechecking seems to
work. Unfortunately, it produces a *lot* of noise, for code such as

static ssize_t disk_show(struct subsystem * subsys, char * buf)
{
        return sprintf(buf, "%s\n", pm_disk_modes[pm_disk_mode]);
}

...where pm_disk_mode is __bitwise. That is not really what we
want. Would it be possible to get something similar to __bitwise where
arithmetic is still okay to do? With __bitwise, I'd need to do:

@@ -292,15 +297,15 @@
        int i;
        int len;
        char *p;
-       u32 mode = 0;
+       suspend_disk_method_t mode = 0;

        p = memchr(buf, '\n', n);
        len = p ? p - buf : n;

        down(&pm_sem);
-       for (i = PM_DISK_FIRMWARE; i < PM_DISK_MAX; i++) {
+       for (i = (int __force) PM_DISK_FIRMWARE; i < (int __force) PM_DISK_MAX; i++) {
                if (!strncmp(buf, pm_disk_modes[i], len)) {
-                       mode = i;
+                       mode = (suspend_disk_method_t __force) i;
                        break;
                }
        }


...thats ugly.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
