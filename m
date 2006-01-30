Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWA3RjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWA3RjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWA3RjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:39:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:65246 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964839AbWA3RjH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:39:07 -0500
Subject: Re: [Xen-devel] Re: [PATCH 2.6.12.6-xen] sysfs attributes for xen
From: Dave Hansen <haveblue@us.ibm.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <43DE4A1D.4050501@us.ibm.com>
References: <43DAD4DB.4090708@us.ibm.com>
	 <1138637931.19801.101.camel@localhost.localdomain>
	 <43DE45A4.6010808@us.ibm.com>
	 <1138640666.19801.106.camel@localhost.localdomain>
	 <43DE4A1D.4050501@us.ibm.com>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 09:38:56 -0800
Message-Id: <1138642737.22903.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 12:17 -0500, Mike D. Day wrote:
> Dave Hansen wrote:
> > In the final version, there will be available Xen headers, and the
> patch
> > won't need the open-coded 1024?
> 
> Good question, I need some advice. The Xen hcall headers get
> soft-linked into every paravirtualized OS tree: linux, bsd, solaris,
> etc. In linux right now the xen version.h shows up
> as /include/asm-xen/version.h.

But, you can #include it from any old Linux file and not care, right?

> This file uses typedefs for every important parameter. For example,
> typedef char [1024] xen_capabilities_info_t;. 
> 
> But as Greg says TYPEDEFS ARE EVIL. 

Yes, they are.  Buuuuuuut, you _can_ make the code around them a little
less evil.  If you _must_ use a typedef, you could do something like
this:

#define XEN_CAP_INFO_LEN_BYTES 1024
typedef char [XEN_CAP_INFO_LEN_BYTES] xen_capabilities_info_t;

That way, you can do your thing without using the typedef in the sysfs
code.  The very best way to do it is to skip the typedef altogether, and
just explicitly create char[] arrays with the length macro when you need
them.

If you did this, and dynamically allocated the buffer, your cap_show
function could look something like this:

+/* xen capabilities info */
+static ssize_t xen_cap_show(struct kobject *kobj,
+                               struct attribute *attr,
+                               char *sysfs_buf)
+{
+	ssize_t result = 0;
+       char *info_buf;
+
+	/* +1 is to make room for the \n in the snprintf */
+	info_buf = kmalloc(XEN_CAP_INFO_LEN_BYTES+1, GFP_KERNEL);
+       if(!info_buf)
+		return result;
+
+	if (HYPERVISOR_xen_version(XENVER_capabilities, &info_buf))
+		goto out;
+
+       result = snprintf(sysfs_buf, XEN_CAP_INFO_LEN_BYTES+1,
+                               "%s\n", info_buf);
+out:
+       kfree(info_buf);
+       return result;
+}

> Last resort would be to use the funky gcc #include_next to override
> the xen hcall headers with a linux-specific hcall headers. But I don't
> know if that would be cool with lkml either. 

I've never seen that done, so I'd try to steer clear.  

-- Dave

