Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUBZXd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbUBZXcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:32:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:49913 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261234AbUBZXaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:30:19 -0500
Message-ID: <403E8180.1060008@mvista.com>
Date: Thu, 26 Feb 2004 15:30:08 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Tom Rini <trini@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][3/3] Update CVS KGDB's wrt connect /
 detach
References: <20040225213626.GF1052@smtp.west.cox.net> <20040225214343.GG1052@smtp.west.cox.net> <20040225215309.GI1052@smtp.west.cox.net> <200402261344.49261.amitkale@emsyssoft.com>
In-Reply-To: <200402261344.49261.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Thursday 26 Feb 2004 3:23 am, Tom Rini wrote:
> 
>>The following patch fixes a number of little issues here and there, and
>>ends up making things more robust.
>>- We don't need kgdb_might_be_resumed or kgdb_killed_or_detached.
>>  GDB attaching is GDB attaching, we haven't preserved any of the
>>  previous context anyhow.
> 
> 
> If gdb is restarted, kgdb has to remove all breakpoints. Present kgdb does 
> that in the code this patch removes:
> 
> -		if (remcom_in_buffer[0] == 'H' && remcom_in_buffer[1] == 'c') {
> -			remove_all_break();
> -			atomic_set(&kgdb_killed_or_detached, 0);
> -			ok_packet(remcom_out_buffer);
> 
> If we don't remove breakpoints, they stay in kgdb without gdb not knowing it 
> and causes consistency problems.

I wonder if this is worth the trouble.  Does kgdb need to know about breakpoints 
at all?  Is there some other reason it needs to track them?
> 
> 
>>- Don't try and look for a connection in put_packet, after we've tried
>>  to put a packet.  Instead, when we receive a packet, GDB has
>>  connected.
> 
> 
> We have to check for gdb connection in putpacket or else following problem 
> occurs.
> 
> 1. kgdb console messages are to be put.
> 2. gdb dies
> 3. putpacket writes the packet and waits for a '+'

Oops!  Tom, this '+' will be sent under interrupt and while kgdb is not 
connected.  Looks like it needs to be passed through without causing a 
breakpoint.  Possible salvation if we disable interrupts while waiting for the 
'+' but I don't think that is a good idea.

-g

> 4. new gdb sends a protocol initialization packet
> 5. putpacket reads characters in that packet hoping for an incoming '+' 
> sending out console message packet on each incoming character
> 6. gdb receives and rejects each console message packet
> 
> 
>>- Remove ok_packet(), excessive, IMHO.
> 
> 
> ok_packet is better than littering "OK" all over the place.
> 
> Other lindent changes are good.
> 
> -Amit
> 
> 
>># This is a BitKeeper generated patch for the following project:
>># Project Name: Linux kernel tree
>># This patch format is intended for GNU patch command version 2.5 or
>>higher. # This patch includes the following deltas:
>>#	           ChangeSet	1.1664  -> 1.1665
>>#	arch/ppc/8260_io/uart.c	1.31    -> 1.32
>>#	       kernel/kgdb.c	1.4     -> 1.5
>>#
>># The following is the BitKeeper ChangeSet Log
>># --------------------------------------------
>># 04/02/25	trini@kernel.crashing.org	1.1665
>># - Kill kgdb_might_be_resumed and kgdb_killed_or_detached.
>># - Spacing and comments.
>># - put_packet doesn't try and check for a connect now.
>># - Kill ok_packet().
>># - Only send an initial packet in kgdb_handle_exception if
>>#   kgdb has connected already.
>># --------------------------------------------
>>#
>>diff -Nru a/arch/ppc/8260_io/uart.c b/arch/ppc/8260_io/uart.c
>>--- a/arch/ppc/8260_io/uart.c	Wed Feb 25 14:21:38 2004
>>+++ b/arch/ppc/8260_io/uart.c	Wed Feb 25 14:21:38 2004
>>@@ -396,14 +396,8 @@
>> #ifdef CONFIG_KGDB
>> 		if (info->state->smc_scc_num == KGDB_SER_IDX) {
>> 			while (i-- > 0) {
>>-				if (*cp == 0x03) {
>>+				if (*cp == 0x03 || *cp == '$') {
>> 					breakpoint();
>>-					return;
>>-				}
>>-				if (*cp == '$') {
>>-					atomic_set(&kgdb_might_be_resumed, 1);
>>-					breakpoint();
>>-					atomic_set(&kgdb_might_be_resumed, 0);
>> 					return;
>> 				}
>> 				cp++;
>>diff -Nru a/kernel/kgdb.c b/kernel/kgdb.c
>>--- a/kernel/kgdb.c	Wed Feb 25 14:21:38 2004
>>+++ b/kernel/kgdb.c	Wed Feb 25 14:21:38 2004
>>@@ -15,6 +15,7 @@
>>  * Copyright (C) 2002-2004 Timesys Corporation
>>  * Copyright (C) 2003-2004 Amit S. Kale
>>  * Copyright (C) 2004 Pavel Machek <pavel@suse.cz>
>>+ * Copyright (C) 2004 Tom Rini <trini@kernel.crashing.org>
>>  *
>>  * Restructured KGDB for 2.6 kernels.
>>  * thread support, support for multiple processors,support for ia-32(x86)
>>@@ -87,8 +88,6 @@
>> static spinlock_t slavecpulocks[KGDB_MAX_NO_CPUS];
>> static volatile int procindebug[KGDB_MAX_NO_CPUS];
>> atomic_t kgdb_setting_breakpoint;
>>-atomic_t kgdb_killed_or_detached;
>>-atomic_t kgdb_might_be_resumed;
>> struct task_struct *kgdb_usethread, *kgdb_contthread;
>>
>> int debugger_step;
>>@@ -212,8 +211,10 @@
>> 	char ch;
>>
>> 	do {
>>-		/* wait around for the start character, ignore all other characters */
>>-		while ((ch = (kgdb_serial->read_char() & 0x7f)) != '$') ;
>>+		/* wait around for the start character, ignore all other
>>+		 * characters */
>>+		while ((ch = (kgdb_serial->read_char() & 0x7f)) != '$')
>>+			;	/* Spin. */
>> 		kgdb_connected = 1;
>> 		checksum = 0;
>> 		xmitcsum = -1;
>>@@ -249,27 +250,22 @@
>>  * Send the packet in buffer.
>>  * Check for gdb connection if asked for.
>>  */
>>-static void put_packet(char *buffer, int checkconnect)
>>+static void put_packet(char *buffer)
>> {
>> 	unsigned char checksum;
>> 	int count;
>> 	char ch;
>>-	static char gdbseq[] = "$Hc-1#09";
>>-	int i;
>>-	int send_count;
>>
>> 	/*  $<packet info>#<checksum>. */
>> 	do {
>> 		kgdb_serial->write_char('$');
>> 		checksum = 0;
>> 		count = 0;
>>-		send_count = 0;
>>
>> 		while ((ch = buffer[count])) {
>> 			kgdb_serial->write_char(ch);
>> 			checksum += ch;
>> 			count++;
>>-			send_count++;
>> 		}
>>
>> 		kgdb_serial->write_char('#');
>>@@ -277,30 +273,7 @@
>> 		kgdb_serial->write_char(hexchars[checksum % 16]);
>> 		if (kgdb_serial->flush)
>> 			kgdb_serial->flush();
>>-
>>-		i = 0;
>>-		while ((ch = kgdb_serial->read_char()) == gdbseq[i++] &&
>>-		       checkconnect) {
>>-			if (!gdbseq[i]) {
>>-				kgdb_serial->write_char('+');
>>-				if (kgdb_serial->flush)
>>-					kgdb_serial->flush();
>>-				breakpoint();
>>-
>>-				/*
>>-				 * GDB is available now.
>>-				 * Retransmit this packet.
>>-				 */
>>-				break;
>>-			}
>>-		}
>>-		if (checkconnect && ch == 3) {
>>-			kgdb_serial->write_char('+');
>>-			if (kgdb_serial->flush)
>>-				kgdb_serial->flush();
>>-			breakpoint();
>>-		}
>>-	} while ((ch & 0x7f) != '+');
>>+	} while ((kgdb_serial->read_char() & 0x7f) != '+');
>>
>> }
>>
>>@@ -427,11 +400,6 @@
>> 	pkt[3] = '\0';
>> }
>>
>>-static void ok_packet(char *pkt)
>>-{
>>-	strcpy(pkt, "OK");
>>-}
>>-
>> static char *pack_threadid(char *pkt, threadref * id)
>> {
>> 	char *limit;
>>@@ -502,7 +470,8 @@
>> 	procindebug[processor] = 1;
>> 	current->thread.debuggerinfo = regs;
>>
>>-	/* Wait till master processor goes completely into the debugger. FIXME:
>>this looks racy */ +	/* Wait till master processor goes completely into the
>>debugger. +	 * FIXME: this looks racy */
>> 	while (!procindebug[atomic_read(&debugger_active) - 1]) {
>> 		int i = 10;	/* an arbitrary number */
>>
>>@@ -701,17 +670,7 @@
>> 	/* Master processor is completely in the debugger */
>> 	kgdb_post_master_code(linux_regs, exVector, err_code);
>>
>>-	if (atomic_read(&kgdb_killed_or_detached) &&
>>-	    atomic_read(&kgdb_might_be_resumed)) {
>>-		get_packet(remcom_in_buffer);
>>-		if (remcom_in_buffer[0] == 'H' && remcom_in_buffer[1] == 'c') {
>>-			remove_all_break();
>>-			atomic_set(&kgdb_killed_or_detached, 0);
>>-			ok_packet(remcom_out_buffer);
>>-		} else
>>-			return 1;
>>-	} else {
>>-
>>+	if (kgdb_connected) {
>> 		/* reply to host that an exception has occurred */
>> 		ptr = remcom_out_buffer;
>> 		*ptr++ = 'T';
>>@@ -721,11 +680,9 @@
>> 		int_to_threadref(&thref, shadow_pid(current->pid));
>> 		ptr = pack_threadid(ptr, &thref);
>> 		*ptr++ = ';';
>>-		*ptr = '\0';
>>-	}
>>
>>-	put_packet(remcom_out_buffer, 0);
>>-	kgdb_connected = 1;
>>+		put_packet(remcom_out_buffer);
>>+	}
>>
>> 	kgdb_usethread = current;
>> 	kgdb_usethreadid = shadow_pid(current->pid);
>>@@ -798,7 +755,7 @@
>> 			else {
>> 				gdb_regs_to_regs(gdb_regs, (struct pt_regs *)
>> 						 current->thread.debuggerinfo);
>>-				ok_packet(remcom_out_buffer);
>>+				strcpy(remcom_out_buffer, "OK");
>> 			}
>>
>> 			break;
>>@@ -838,10 +795,10 @@
>> 			if ((error = remove_all_break()) < 0) {
>> 				error_packet(remcom_out_buffer, error);
>> 			} else {
>>-				ok_packet(remcom_out_buffer);
>>+				strcpy(remcom_out_buffer, "OK");
>> 				kgdb_connected = 0;
>> 			}
>>-			put_packet(remcom_out_buffer, 0);
>>+			put_packet(remcom_out_buffer);
>> 			goto default_handle;
>>
>> 		case 'k':
>>@@ -947,11 +904,10 @@
>> 				}
>> 				kgdb_usethread = thread;
>> 				kgdb_usethreadid = threadid;
>>-				ok_packet(remcom_out_buffer);
>>+				strcpy(remcom_out_buffer, "OK");
>> 				break;
>>
>> 			case 'c':
>>-				atomic_set(&kgdb_killed_or_detached, 0);
>> 				ptr = &remcom_in_buffer[2];
>> 				kgdb_hex2long(&ptr, &threadid);
>> 				if (!threadid) {
>>@@ -966,7 +922,7 @@
>> 					}
>> 					kgdb_contthread = thread;
>> 				}
>>-				ok_packet(remcom_out_buffer);
>>+				strcpy(remcom_out_buffer, "OK");
>> 				break;
>> 			}
>> 			break;
>>@@ -977,7 +933,7 @@
>> 			kgdb_hex2long(&ptr, &threadid);
>> 			thread = getthread(linux_regs, threadid);
>> 			if (thread)
>>-				ok_packet(remcom_out_buffer);
>>+				strcpy(remcom_out_buffer, "OK");
>> 			else
>> 				error_packet(remcom_out_buffer, -EINVAL);
>> 			break;
>>@@ -1018,7 +974,7 @@
>> 			}
>>
>> 			if (error == 0)
>>-				ok_packet(remcom_out_buffer);
>>+				strcpy(remcom_out_buffer, "OK");
>> 			else
>> 				error_packet(remcom_out_buffer, error);
>>
>>@@ -1039,7 +995,7 @@
>> 		}		/* switch */
>>
>> 		/* reply to the request */
>>-		put_packet(remcom_out_buffer, 0);
>>+		put_packet(remcom_out_buffer);
>> 	}
>>
>>       kgdb_exit:
>>@@ -1063,7 +1019,6 @@
>> 	}
>>
>> 	/* Free debugger_active */
>>-	atomic_set(&kgdb_killed_or_detached, 1);
>> 	atomic_set(&debugger_active, 0);
>> 	local_irq_restore(flags);
>>
>>@@ -1132,12 +1087,6 @@
>> 	/* Free debugger_active */
>> 	atomic_set(&debugger_active, 0);
>>
>>-	/* This flag is used, if gdb has detached and wants to start
>>-	 * another session
>>-	 */
>>-	atomic_set(&kgdb_killed_or_detached, 1);
>>-	atomic_set(&kgdb_might_be_resumed, 0);
>>-
>> 	for (i = 0; i < MAX_BREAKPOINTS; i++)
>> 		kgdb_break[i].state = bp_disabled;
>>
>>@@ -1222,7 +1171,7 @@
>> 		*bufptr = '\0';
>> 		s += wcount;
>>
>>-		put_packet(kgdbconbuf, 1);
>>+		put_packet(kgdbconbuf);
>>
>> 	}
>> 	local_irq_restore(flags);
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

