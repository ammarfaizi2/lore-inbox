Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318974AbSIKOSO>; Wed, 11 Sep 2002 10:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319021AbSIKOSO>; Wed, 11 Sep 2002 10:18:14 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:7558 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318974AbSIKOSL>;
	Wed, 11 Sep 2002 10:18:11 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 11 Sep 2002 08:22:24 -0600
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Fix APM for Sony Vaio against v2.4
Message-ID: <20020911082224.B11852@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a problem with Sony Vaio laptops where they don't notify
the kernel of power source change events.  That means apmd is never told
and many of the apmd features can't be used.

The Sony Vaio doesn't send APM events to the kernel telling it
about 'going on battery' or 'going on AC power' events.  It will register
them correctly if they're queried but it won't asynchronously send an event
so the kernel never tells apmd about it.

This patch fixes the situation by checking against the last known power
state (and power source) in the check_status() call.

This was tested on a Sony Vaio z505js, model PCG-5201 and it works
beautifully.  I'm told other Vaio notebooks have this same problem and this
fixes it as well.  Now, Vaio users can setup apmd to aggressively try to
save power when on battery or perform other crazy tasks.


This BitKeeper patch contains the following changesets:
cort@ftsoj.fsmlabs.com|ChangeSet|20020804093339|04577

# ID:	torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
# User:	cort
# Host:	host110.fsmlabs.com
# Root:	/sys/linux-2.4

# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
kaos@ocs.com.au|ChangeSet|20020803040640|04387
D 1.555.17.1 02/08/04 03:33:39-06:00 cort@ftsoj.fsmlabs.com +3 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Work around the Sony Vaio APM on-AC/on-battery problem.
c 
c Sony Vaios won't send asynchronous notifies to the kernel
c of on-battery/on-AC events so we have to track the last known
c power source and send events when it changes.
c 
c apmd now functions properly on the Vaio.
K 4577
P ChangeSet
------------------------------------------------

0a0
> torvalds@athlon.transmeta.com|arch/i386/kernel/dmi_scan.c|20020205174021|13175|15e3b244aee71d2f cort@ftsoj.fsmlabs.com|arch/i386/kernel/dmi_scan.c|20020804093337|31396
> torvalds@athlon.transmeta.com|arch/i386/kernel/apm.c|20020205174021|61680|259653a2cd523ef6 cort@ftsoj.fsmlabs.com|arch/i386/kernel/apm.c|20020804093336|32440
> torvalds@athlon.transmeta.com|include/asm-i386/system.h|20020205173944|24935|ee44db59434639d cort@ftsoj.fsmlabs.com|include/asm-i386/system.h|20020804093337|25618

== arch/i386/kernel/apm.c ==
torvalds@athlon.transmeta.com|arch/i386/kernel/apm.c|20020205174021|61680|259653a2cd523ef6
alan@lxorguk.ukuu.org.uk|arch/i386/kernel/apm.c|20020717234052|40131
D 1.17 02/08/04 03:33:36-06:00 cort@ftsoj.fsmlabs.com +27 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Work around the Sony Vaio APM on-AC/on-battery problem.
c 
c Sony Vaios won't send asynchronous notifies to the kernel
c of on-battery/on-AC events so we have to track the last known
c power source and send events when it changes.
c 
c apmd now functions properly on the Vaio.
K 32440
O -rw-rw-r--
P arch/i386/kernel/apm.c
------------------------------------------------

I1341 27
\
	/*
	 * The Sony Vaio doesn't seem to want to send us a notify
	 * about AC line power status changes.  So, we have to keep track
	 * of it by hand and emulate it here.
	 *   -- Cort <cort@fsmlabs.com>
	 */
	if ( apm_bios_power_change_bug ) {
		static int last_status = 0;
		u_short status, bat, life;
\
		/* get the current power state */
		if ( apm_get_power_status(&status, &bat, &life) !=
		     APM_SUCCESS ) {
			printk("%s:%s error checking power status\n",
			       __FILE__,__FUNCTION__);
		}
		
		/* has the status changed since we were last here? */
		if (((status >> 8) & 0xff) != last_status) {
			last_status = (status >> 8) & 0xff;
			
			/* fake a APM_POWER_STATUS_CHANGE event */
			queue_event(APM_POWER_STATUS_CHANGE, NULL);
		}
		
	}

== arch/i386/kernel/dmi_scan.c ==
torvalds@athlon.transmeta.com|arch/i386/kernel/dmi_scan.c|20020205174021|13175|15e3b244aee71d2f
mikpe@csd.uu.se|arch/i386/kernel/dmi_scan.c|20020507002723|22063
D 1.22 02/08/04 03:33:37-06:00 cort@ftsoj.fsmlabs.com +28 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Work around the Sony Vaio APM on-AC/on-battery problem.
c 
c Sony Vaios won't send asynchronous notifies to the kernel
c of on-battery/on-AC events so we have to track the last known
c power source and send events when it changes.
c 
c apmd now functions properly on the Vaio.
K 31396
O -rw-rw-r--
P arch/i386/kernel/dmi_scan.c
------------------------------------------------

I15 1
int apm_bios_power_change_bug = 0;
I405 21
\
/*
 * Some Vaio laptops don't notify the kernel of a power status change
 * such as on-AC/on-battery.  This detects some of the faulty machines
 * and sets a variable that lets arch/i386/kernel/apm.c deal with it.
 *
 * I've seen this with the Vaio z505js PCG-5201 and PCG-SR33:
 
 * model PCG-Z505JS(UC), bios Phoenix Technologies LTD version R0121Z1
 * model PCG-SR33(UC), bios Phoenix Technologies LTD version R0211D1
 *   -- Cort <cort@fsmlabs.com>
 */ 
static __init int sony_vaio_apm_change(struct dmi_blacklist *d)
{
	apm_bios_power_change_bug = 1;
	printk(KERN_WARNING "%s detected: APM power status change workaround enabled\n",
	       d->ident);
	return 0;
}
\
\
I748 6
			} },
\
	{ sony_vaio_apm_change, "Sony Vaio", {	/* APM won't send power change events */
			MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
			MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
			NO_MATCH, NO_MATCH

== include/asm-i386/system.h ==
torvalds@athlon.transmeta.com|include/asm-i386/system.h|20020205173944|24935|ee44db59434639d
patch@athlon.transmeta.com|include/asm-i386/system.h|20020205203241|21876
D 1.11 02/08/04 03:33:37-06:00 cort@ftsoj.fsmlabs.com +1 -0
B torvalds@athlon.transmeta.com|ChangeSet|20020205173056|16047|c1d11a41ed024864
C
c Work around the Sony Vaio APM on-AC/on-battery problem.
c 
c Sony Vaios won't send asynchronous notifies to the kernel
c of on-battery/on-AC events so we have to track the last known
c power source and send events when it changes.
c 
c apmd now functions properly on the Vaio.
K 25618
O -rw-rw-r--
P include/asm-i386/system.h
------------------------------------------------

I354 1
extern int apm_bios_power_change_bug;

# Patch checksum=1e0e3275

