Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVBKLP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVBKLP6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 06:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVBKLP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 06:15:58 -0500
Received: from sd291.sivit.org ([194.146.225.122]:46798 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262251AbVBKLPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 06:15:32 -0500
Date: Fri, 11 Feb 2005 12:17:09 +0100
From: Stelian Pop <stelian@popies.net>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050211111709.GF3263@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Jean Delvare <khali@linux-fr.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net
References: <20050210161809.GK3493@crusoe.alcove-fr> <420C894B.1090700@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420C894B.1090700@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 11:30:35AM +0100, Jean Delvare wrote:

> Hi Stelian, all,
> 
> >This driver has been submitted (almost unchanged) on lkml and 
> >on acpi-devel twice, first on July 21, 2004, then again on
> >September 17, 2004. It has been quietly ignored.
> >
> >Privately I've had many positive feedbacks from users of this driver
> >(and no negative feedback), including Linux distributions who wish
> >to include it into their kernels. The reports are increasing in number,
> >it would seem that newer Sony Vaios are more and more incompatible
> >with sonypi and require sony_acpi to control the screen brightness.
> 
> I'm sorry I missed the first two announcements. I'll give a try to your 
> driver this evening, and report how it is working for me.

thanks.

> In the meantime, I'd have some comments on your patch:
> 
> >+static int debug = 0;

> No need to initialize it to 0, the compiler does it for you (and more 
> efficiently at that).

sure.
> 
> >+module_param(debug, int, 0);
> >+MODULE_PARM_DESC(debug,"set this to 1 (and RTFM) if you want to help the 
> >development of this driver");
> 
> Lack of space after comma, and line too long, split it please.

done.

> >+static struct acpi_driver sony_acpi_driver = {
> >+	name:	ACPI_SNC_DRIVER_NAME,
> >+	class:	ACPI_SNC_CLASS,
> >+	ids:	ACPI_SNC_HID,
> >+	ops:	{
> >+			add:	sony_acpi_add,
> >+			remove:	sony_acpi_remove,
> >+		},
> >+};
> 
> As far as I know, you are supposed to use C99-style for structure 
> initialization:
>     .name = ACPI_SNC_DRIVER_NAME,
> etc.

of course.

> >+	printk(KERN_WARNING "acpi_callreadfunc failed\n");
> 
> Please prepend the driver name before such messages (everywhere in the 
> driver). It's annoying when you see error messages in your logs and 
> don't know which driver caused them.

done.

> >+static int parse_buffer(const char __user *buffer, unsigned long count, 
> >int *val) {
> >+	char s[32];
> >+	
> >+	if (count > 31)
> >+		return -EINVAL;
> >+	if (copy_from_user(s, buffer, count))
> >+		return -EFAULT;
> >+	s[count] = 0;
> 
> = '\0' would look better IMHO.
> 
> >+	if (sscanf(s, "%i", val) != 1)
> 
> Can't you use simple_strtoul instead? This would be more efficient, or 
> so I guess.

Indeed, sscanf calls simple_strtoul.

> 
> >--- /dev/null	2005-02-10 10:35:32.824183288 +0100
> >+++ linux-2.6-stelian/Documentation/sony_acpi.txt	2005-01-31 
> >17:00:09.000000000 +0100
> 
> Could be the time to create a Documentation/acpi directory and start 
> populating it. It's odd that such a large subsystem has no documentation 
> in the kernel tree.

I agree. Let's see if the acpi people follow :)

> >+You should start by trying the sonypi driver, which does
> >+all this and many other things. But the sonypi driver does
> >+not work on all sonypi laptops, whereas sony_acpi should 
> >+work everywhere.
> 
> s/all sonypi laptops/all Sony laptops/?

doh :)

> >+Loading the sony_acpi.ko module will create a /proc/acpi/sony/
> >+directory populated with a couple of files (only one for the
> >+moment).
> 
> s/sony_acpi\.ko/sony_acpi/
> .ko is an implementation detail the user-space should not have to care 
> about.

yup.

> >+For example:
> >+	# echo "1" > /proc/acpi/sony/brt
> 
> BTW, why not naming the file "brightness" instead? Most acpi files have 
> "long" names like that. At least people can easily figure out what the 
> files are for.

Agreed.

> >+config ACPI_SONY
> >+	tristate "Sony Laptop Extras" 
> >+	depends on X86
> >+	depends on ACPI_INTERPRETER
> >+	default m
> >+	  ---help---
> >+	  This mini-driver drives the ACPI SNC device present in the
> >+	  ACPI BIOS of the Sony Vaio laptops.
> >+
> >+	  It gives access to some extra laptop functionalities. In
> >+	  its current form, the only thing this driver does is letting 
> >+	  the user set or query the screen brightness.
> >+
> >+	  Read <Documentation/sony_acpi.txt> for more information.
> 
> I think I remember this should be <file:Documentation...> or something 
> similar.

correct.

> Note that I have next to zero knowledge of the acpi internals so I 
> couldn't comment on that part.

Hey, that's not so bad :)

An updated version will follow.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
