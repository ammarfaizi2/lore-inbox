Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267373AbTACESX>; Thu, 2 Jan 2003 23:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267376AbTACESX>; Thu, 2 Jan 2003 23:18:23 -0500
Received: from dp.samba.org ([66.70.73.150]:36238 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267373AbTACEST>;
	Thu, 2 Jan 2003 23:18:19 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Wang, Stanley" <stanley.wang@intel.com>
Cc: "Zhuang, Louis" <louis.zhuang@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: Kernel module version support. 
In-reply-to: Your message of "Thu, 02 Jan 2003 22:25:31 +0800."
             <957BD1C2BF3CD411B6C500A0C944CA2602AFADC0@pdsmsx32.pd.intel.com> 
Date: Fri, 03 Jan 2003 11:00:08 +1100
Message-Id: <20030103042650.6DDD82C0B1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <957BD1C2BF3CD411B6C500A0C944CA2602AFADC0@pdsmsx32.pd.intel.com> you
 write:
> Hi, Rusty
> I am interested in your module version support implementation. I've read
> your description about it.

Cool.  That reminds me.

> 1. How do you plan to store the version information of a kernel module that
> will export some symbols?
> (In the version table of "bzImage"? In a specified section in this kernel
> module? In other place? Or don't
> store?)

Currently I don't do this.  I discussed solutions briefly with Kai
some time ago, but I'll have to revisit it.  Getting the core kernel
symbols versioned covers 90% of the problem though, and shows the
validity of the approach.

> 2. You mentioned that "modules which want to export symbols place
> their full path name in the .needmodversion section. Just before the
> kernel is linked, these names are extracted, and genksyms scans
> those files to create a version table. This table is then linked
> into the kernel".  And I think we must recalculate all version
> informaiton every time when we re built the kernel in this way.  Why
> don't we place all the module version information in some files just
> like old days.

That's a build system detail: it can use that list to generate the
versions on demand of course.

> 3. You mentioned that "these symbol versions are then checked on
> insmod". I wanna whether it means you would like to restore the
> "/proc/ksyms" file or QUERY_MODULE SYSCALL to export the kernel
> version table to the user space application.

The language is a little loose.  The kernel does the actual checking:

#ifdef CONFIG_MODVERSIONING
static inline int check_version(const char *name,
				const char *symname,
				const struct modversion_info *versions,
				unsigned int num)
{
	unsigned int i, k;

	/* First search kernel (unversioned symbols not listed). */
	for (k = 0; !streq(modversions[k].symbol, symname); k++)
		if (!modversions[k].symbol[0])
			return 0;

	/* Now see if module has matching symbol. */
	for (i = 0; i < num; i++) {
		if (streq(versions[i].symbol, symname)) {
			if (versions[i].checksum == modversions[k].checksum)
				return 0;
			printk("%s: disagrees about version of symbol %s\n",
			       name, symname);
			DEBUGP("Kernel checksum %lX vs module %lX\n",
			       modversions[k].checksum, versions[i].checksum);
			return -ESRCH;
		}
	}

	/* Not in module's version table.  OK, but that taints the kernel. */
	printk("%s: no version for %s found: kernel tainted.\n",
	       name, symname);
	tainted |= TAINT_FORCED_MODULE;
	return 0;
}

Hope that clarifies,
Rusty.
PS.  I'll update the patch soon, I promise...
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
