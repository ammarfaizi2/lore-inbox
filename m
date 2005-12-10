Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbVLJUFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbVLJUFa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 15:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbVLJUFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 15:05:30 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:37841 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1161058AbVLJUF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 15:05:29 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC/RFT] swsusp: image size tunable (was: Re: [PATCH][mm] swsusp: limit image size)
Date: Sat, 10 Dec 2005 21:06:41 +0100
User-Agent: KMail/1.9
Cc: Stefan Seyfried <seife@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Andy Isaacson <adi@hexapodia.org>
References: <200512072246.06222.rjw@sisk.pl> <200512101421.57918.rjw@sisk.pl> <20051210160641.GB5047@elf.ucw.cz>
In-Reply-To: <20051210160641.GB5047@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512102106.41952.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday, 10 December 2005 17:06, Pavel Machek wrote:
> > > The tunable may be useful to people who'd like to achieve the
> > > maximum efficiency of suspend/resume and it would be a nice
> > > feature to have, I think, but let's say we'll try to implement it
> > > in the future, if still needed/wanted.
> > 
> > Actually the tunable turned out to be quite easy to implement and I think
> > I'll need it for userspace swsusp (the suspend-handling userspace
> > process will need to tell the kernel how much space there is for the
> > image).
> 
> Looks mostly okay to me, small comments below.
> 
> > Index: linux-2.6.15-rc5-mm1/kernel/power/disk.c
> > ===================================================================
> > --- linux-2.6.15-rc5-mm1.orig/kernel/power/disk.c	2005-12-10 13:12:18.000000000 +0100
> > +++ linux-2.6.15-rc5-mm1/kernel/power/disk.c	2005-12-10 13:20:38.000000000 +0100
> > @@ -367,9 +367,34 @@
> >  
> >  power_attr(resume);
> >  
> > +static ssize_t image_size_show(struct subsystem * subsys, char *buf)
> > +{
> > +	return sprintf(buf, "%u\n", image_size);
> > +}
> > +
> > +static ssize_t image_size_store(struct subsystem * subsys, const char * buf, size_t n)
> > +{
> > +	int len;
> > +	char *p;
> > +	unsigned int size;
> > +
> > +	p = memchr(buf, '\n', n);
> > +	len = p ? p - buf : n;
> 
> len and p are unused.

Right.  BTW, the same applies to resume_store().

> 
> > +	if (sscanf(buf, "%u", &size) == 1) {
> > +		image_size = size < MAX_IMAGE_SIZE ? size : MAX_IMAGE_SIZE;
> > +		return n;
> 
> Why the limit? We may want to allow very big images when someone wants
> "as similar to suspended system as possible".

It's not really necessary.  I'll remove it.

> 
> > Index: linux-2.6.15-rc5-mm1/kernel/power/power.h
> > ===================================================================
> > --- linux-2.6.15-rc5-mm1.orig/kernel/power/power.h	2005-12-10 13:12:18.000000000 +0100
> > +++ linux-2.6.15-rc5-mm1/kernel/power/power.h	2005-12-10 13:20:46.000000000 +0100
> > @@ -53,10 +53,12 @@
> >  extern struct pbe *pagedir_nosave;
> >  
> >  /*
> > - * Preferred image size in MB (set it to zero to get the smallest
> > + * Maximum image size in MB (set it to zero to get the smallest
> >   * image possible)
> >   */
> 
> In fact this is not maximum. If more than 500MB can't be freed, well,
> it will not be freed. Very improbable, but possible.
> 
> > -#define IMAGE_SIZE	500
> > +#define MAX_IMAGE_SIZE	500
> > +
> 
> With runtime configuration, we should not need additional
> compile-time config. OTOH /proc tunables should have descritption in
> Documentation/.

This only is an experimental version.  I'll write the description for the
final one.

Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
