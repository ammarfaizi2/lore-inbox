Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbULWM6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbULWM6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 07:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbULWM6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 07:58:30 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:62222 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261224AbULWM6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 07:58:23 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.x BUGs at boot time (APIC related)
Date: Thu, 23 Dec 2004 14:57:25 +0000
X-Mailer: KMail [version 1.4]
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
References: <200412221731.20105.vda@port.imtp.ilyichevsk.odessa.ua> <200412231102.10171.vda@port.imtp.ilyichevsk.odessa.ua> <20041223091243.GA771@holomorphy.com>
In-Reply-To: <20041223091243.GA771@holomorphy.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_P7K6P5SZ4XCITEWGH4HE"
Message-Id: <200412231457.25944.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_P7K6P5SZ4XCITEWGH4HE
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 23 December 2004 09:12, William Lee Irwin III wrote:
> On Wednesday 22 December 2004 17:31, Denis Vlasenko wrote:
> >>         if (!apic_id_registered())
> >>                 BUG();   <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> On Thu, Dec 23, 2004 at 11:02:09AM +0000, Denis Vlasenko wrote:
> > Tested with noapic nolapic boot params. Still happens.
> > Call chain is init() -> APIC_init_uniprocessor() ->
> > ->  setup_local_APIC(). I am a bit suspicious why
> > APIC_init_uniprocessor() does not bail out
> > if enable_local_apic<0 (i.e. if I boot with "nolapic"):
> > int __init APIC_init_uniprocessor (void)
> > {
> >         if (enable_local_apic < 0)
> >                 clear_bit(X86_FEATURE_APIC,
> > boot_cpu_data.x86_capability); <=3D=3D=3D=3D=3D missing "return -1"?
> >
> >         if (!smp_found_config && !cpu_has_apic)
> >                 return -1;
> > ...
>
> Sounds pretty serious. What happens if you add the missing return -1?

Just tested that. It booted ok. Patch is in attachment.
--=20
vda
--------------Boundary-00=_P7K6P5SZ4XCITEWGH4HE
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="apic.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="apic.c.diff"

--- linux-2.6.10-rc3.src/arch/i386/kernel/apic.c.old	Mon Dec 20 14:13:59 2004
+++ linux-2.6.10-rc3.src/arch/i386/kernel/apic.c	Thu Dec 23 08:54:13 2004
@@ -1250,8 +1250,10 @@
  */
 int __init APIC_init_uniprocessor (void)
 {
-	if (enable_local_apic < 0)
+	if (enable_local_apic < 0) {
 		clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
+		return -1;
+	}
 
 	if (!smp_found_config && !cpu_has_apic)
 		return -1;

--------------Boundary-00=_P7K6P5SZ4XCITEWGH4HE--

