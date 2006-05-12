Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWELBQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWELBQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 21:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWELBQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 21:16:15 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:57712 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750712AbWELBQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 21:16:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:From:Reply-To:To:Subject:Date:User-Agent:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=kpXXof/JOsrdgm34VhMLNw52wf7pdnXjhCgwoPCN3NZF1eQiA2CnLjLDjz6cDthN8WgM0ZZBEIA629VFdb35Uq0+nUeQ3N+N/xjzgumDsRal7VOFrFlXOx1TAy/JVgdyNqYyQGIpimAbQ+W9tGAhG61lp8ylM64fjzZc96O62j8=  ;
From: Marek W <marekw1977@yahoo.com.au>
Reply-To: marekw1977@yahoo.com.au
To: linux-kernel@vger.kernel.org
Subject: Re: acpi4asus
Date: Fri, 12 May 2006 11:16:11 +1000
User-Agent: KMail/1.9.1
References: <20060511130743.GG15876@mail.muni.cz> <20060511073211.1da40329.akpm@osdl.org>
In-Reply-To: <20060511073211.1da40329.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605121116.11930.marekw1977@yahoo.com.au>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 00:32, you wrote:
> Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> > Hello,
> >
> > is project acpi4asus still alive?
>
> I know of no such project.

Their ML seems to only receive patches from people. There's usually no 
commentary on the patches themselves.

> > (I'm asking here whether Andrew or Linus are
> > receiving patches from acpi guys). For me, it looks like this is somewhat
> > dead.
>
> Well actually I receive asus patches from various people and send them to
> the acpi developers and nothing happens.  So I resend and eventually a few
> stick.
>
> The ACPI team are trying to get away from these machine-specific ACPI
> drivers in favour of doing everything correctly within AML, but there
> doesn't seem to be a lot of progress with that afaict.

I am far from qualified to comment on this, but from a users point of view, is 
it possible to not have laptop specific code in the kernel?
I have had two Linux laptops and with both I had ACPI issues.
The vendors of both laptops (Toshiba Tecra S1 and now an Asus W3V) don't seem 
to be following standards. With both I seem to need to patch ACPI to get 
various functions of the laptop to work.
I would love to see laptop specific functionality definitions exist outside 
the kernel.

> > I posted patch to include Asus M6A support to both lkm and acpi4asus list
> > but no response. I only noticed, that Andrew once tried to include in -mm
> > but I did not see it there anyway.
>
> Missed it - please resend.

Would you mind if I add mine? 
It adds support for W3000 (W3V) and indirectly fixes an issue with kmilo under 
KDE (it was triggering excessive LCD read error messages by querying 
asus_acpi module) allowing people (I am probably the only one who tested 
this) with W3000 to run kmilo.  
The patch is against gentoo-sources-2.6.16-r3 (I believe this corresponds to 
vanilla sources 2.6.16.9 and I don't think gentoo-sources applied any other 
patches against the vanilla asus-acpi.c).

Marek Wawrzyczny
----------------------

--- asus_acpi.c.original        2006-04-13 20:11:24.000000000 +1000
+++ asus_acpi.c 2006-04-20 10:25:40.000000000 +1000
@@ -131,6 +131,7 @@
                P30,            //Samsung P30
                S1x,            //S1300A, but also L1400B and M2400A (L84F)
                S2x,            //S200 (J1 reported), Victor MP-XP7210
+               W3V,            //W3030V
                xxN,            //M2400N, M3700N, M5200N, S1300N, S5200N, 
W1OOON
                //(Centrino)
                END_MODEL
@@ -345,6 +346,17 @@
         .brightness_down = S2x_PREFIX "_Q0A"},

        {
+        .name = "W3V",
+        .mt_mled = "MLED",
+        .mt_wled = "WLED",
+        .mt_lcd_switch = xxN_PREFIX "_Q10",
+        .lcd_status = "\\BKLT",
+        .brightness_set = "SPLV",
+        .brightness_get = "GPLV",
+        .display_set = "SDSP",
+        .display_get = "\\INFB"},
+
+       {
         .name = "xxN",
         .mt_mled = "MLED",
 /* WLED present, but not controlled by ACPI */
@@ -1066,6 +1078,8 @@
                hotk->model = S2x;
        else if (strncmp(model->string.pointer, "L5", 2) == 0)
                hotk->model = L5x;
+       else if (strncmp(model->string.pointer, "W3V", 3) == 0)
+               hotk->model = W3V;

        if (hotk->model == END_MODEL) {
                printk("unsupported, trying default values, supply the "
@@ -1087,9 +1101,10 @@
                hotk->methods->mt_mled = NULL;
        /* S5N and M5N have no MLED */
        else if (strncmp(model->string.pointer, "M2N", 3) == 0 ||
-                strncmp(model->string.pointer, "W1N", 3) == 0)
+                strncmp(model->string.pointer, "W1N", 3) == 0 ||
+                strncmp(model->string.pointer, "W3V", 3) == 0)
                hotk->methods->mt_wled = "WLED";
-       /* M2N and W1N have a usable WLED */
+       /* M2N, W1N and W3V have a usable WLED */
        else if (asus_info) {
                if (strncmp(asus_info->oem_table_id, "L1", 2) == 0)
                        hotk->methods->mled_status = NULL;
Send instant messages to your online friends http://au.messenger.yahoo.com 
