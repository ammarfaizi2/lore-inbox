Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbUBVVDz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 16:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUBVVDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 16:03:55 -0500
Received: from gprs147-171.eurotel.cz ([160.218.147.171]:4228 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261751AbUBVVDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 16:03:33 -0500
Date: Sun, 22 Feb 2004 22:02:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <akale@users.sourceforge.net>
Subject: Re: [1/3] kgdb-lite for 2.6.3
Message-ID: <20040222210224.GB16779@elf.ucw.cz>
References: <20040222160417.GA9535@elf.ucw.cz> <20040222202211.GA2063@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20040222202211.GA2063@mars.ravnborg.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> +static const char hexchars[] = "0123456789abcdef";
> Grepping after 0123456789 in the src tree gives a lot of hits.
> Maybe we should pull in some functionality from klibc, and place it in lib/
> at some point in time.

This one will have to wait, I fixed the others in the internal tree.

Here's the diff
								Pavel



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kgdb.3.diff"

--- clean-mm/arch/i386/kernel/i386-stub.c	2004-02-22 16:43:46.000000000 +0100
+++ linux-mm/arch/i386/kernel/i386-stub.c	2004-02-22 21:42:55.000000000 +0100
@@ -283,7 +283,7 @@
 }
 
 int kgdb_arch_handle_exception(int exceptionVector, int signo,
-		int err_code, char *remcomInBuffer, char *remcomOutBuffer,
+		int err_code, char *remcom_in_buffer, char *remcom_out_buffer,
 		struct pt_regs *linux_regs)
 {
 	long addr, length;
@@ -292,19 +292,19 @@
 	int newPC;
 	int dr6;
 	
-	switch (remcomInBuffer[0]) {
+	switch (remcom_in_buffer[0]) {
 	case 'c':
 	case 's':
 		if (kgdb_contthread && kgdb_contthread != current) {
-			strcpy(remcomOutBuffer, "E00");
+			strcpy(remcom_out_buffer, "E00");
 			break;
 		}
 
 		kgdb_contthread = NULL;
 
 		/* try to read optional parameter, pc unchanged if no parm */
-		ptr = &remcomInBuffer[1];
-		if (kgdb_hexToLong(&ptr, &addr)) {
+		ptr = &remcom_in_buffer[1];
+		if (kgdb_hex2long(&ptr, &addr)) {
 			linux_regs->eip = addr;
 		} 
 		newPC = linux_regs->eip;
@@ -313,7 +313,7 @@
 		linux_regs->eflags &= 0xfffffeff;
 
 		/* set the trace bit if we're stepping */
-		if (remcomInBuffer[0] == 's') {
+		if (remcom_in_buffer[0] == 's') {
 			linux_regs->eflags |= 0x100;
 			debugger_step = 1;
 		}
@@ -336,30 +336,30 @@
 		return (0);
 
 	case 'Y':
-		ptr = &remcomInBuffer[1];
-		kgdb_hexToLong(&ptr, &breakno);
+		ptr = &remcom_in_buffer[1];
+		kgdb_hex2long(&ptr, &breakno);
 		ptr++;
-		kgdb_hexToLong(&ptr, &breaktype);
+		kgdb_hex2long(&ptr, &breaktype);
 		ptr++;
-		kgdb_hexToLong(&ptr, &length);
+		kgdb_hex2long(&ptr, &length);
 		ptr++;
-		kgdb_hexToLong(&ptr, &addr);
+		kgdb_hex2long(&ptr, &addr);
 		if (set_hw_break(breakno & 0x3, breaktype & 0x3, 
 				 length & 0x3, addr) == 0) {
-			strcpy(remcomOutBuffer, "OK");
+			strcpy(remcom_out_buffer, "OK");
 		} else {
-			strcpy(remcomOutBuffer, "ERROR");
+			strcpy(remcom_out_buffer, "ERROR");
 		}
 		break;
 
 		/* Remove hardware breakpoint */
 	case 'y':
-		ptr = &remcomInBuffer[1];
-		kgdb_hexToLong(&ptr, &breakno);
+		ptr = &remcom_in_buffer[1];
+		kgdb_hex2long(&ptr, &breakno);
 		if (remove_hw_break(breakno & 0x3) == 0) {
-			strcpy(remcomOutBuffer, "OK");
+			strcpy(remcom_out_buffer, "OK");
 		} else {
-			strcpy(remcomOutBuffer, "ERROR");
+			strcpy(remcom_out_buffer, "ERROR");
 		}
 		break;
 
--- clean-mm/arch/ppc/kernel/ppc-stub.c	2004-02-22 18:38:38.000000000 +0100
+++ linux-mm/arch/ppc/kernel/ppc-stub.c	2004-02-22 21:48:34.000000000 +0100
@@ -223,13 +223,13 @@
  * This function does PoerPC specific procesing for interfacing to gdb.
  */
 int kgdb_arch_handle_exception (int vector, int signo, int err_code,
-		char *remcomInBuffer, char *remcomOutBuffer,
+		char *remcom_in_buffer, char *remcom_out_buffer,
 		struct pt_regs *linux_regs)
 {
 	char *ptr;
 	unsigned long addr;
 	
-	switch (remcomInBuffer[0])
+	switch (remcom_in_buffer[0])
 		{
 		/*
 		 * sAA..AA   Step one instruction from AA..AA 
@@ -239,7 +239,7 @@
 		case 'c':
 			if (kgdb_contthread && kgdb_contthread != current)
 			{
-				strcpy(remcomOutBuffer, "E00");
+				strcpy(remcom_out_buffer, "E00");
 				break;
 			}
 
@@ -247,11 +247,11 @@
 
 			/* handle the optional parameter */
 			ptr = &remcomInBuffer[1];
-			if (kgdb_hexToLong (&ptr, &addr))
+			if (kgdb_hex2long (&ptr, &addr))
 				linux_regs->nip = addr;
 
 			/* set the trace bit if we're stepping */
-			if (remcomInBuffer[0] == 's')
+			if (remcom_in_buffer[0] == 's')
 			{
 #if defined (CONFIG_4xx)
 				linux_regs->msr |= MSR_DE;
--- clean-mm/arch/x86_64/kernel/x86_64-stub.c	2004-02-22 18:38:42.000000000 +0100
+++ linux-mm/arch/x86_64/kernel/x86_64-stub.c	2004-02-22 21:42:56.000000000 +0100
@@ -297,7 +297,7 @@
 }
 
 int kgdb_arch_handle_exception(int exceptionVector, int signo, int err_code,
-                                 char *remcomInBuffer, char *remcomOutBuffer,
+                                 char *remcom_in_buffer, char *remcom_out_buffer,
                                  struct pt_regs *linux_regs)
 {
 	unsigned long addr, length;
@@ -306,19 +306,19 @@
 	int newPC;
 	unsigned long dr6;
 	
-	switch (remcomInBuffer[0]) {
+	switch (remcom_in_buffer[0]) {
 	case 'c':
 	case 's':
 		if (kgdb_contthread && kgdb_contthread != current) {
-			strcpy(remcomOutBuffer, "E00");
+			strcpy(remcom_out_buffer, "E00");
 			break;
 		}
 
 		kgdb_contthread = NULL;
 
 		/* try to read optional parameter, pc unchanged if no parm */
-		ptr = &remcomInBuffer[1];
-		if (kgdb_hexToLong(&ptr, &addr)) {
+		ptr = &remcom_in_buffer[1];
+		if (kgdb_hex2long(&ptr, &addr)) {
 			linux_regs->rip = addr;
 		} 
 		newPC = linux_regs->rip;
@@ -327,7 +327,7 @@
 		linux_regs->eflags &= 0xfffffeff;
 
 		/* set the trace bit if we're stepping */
-		if (remcomInBuffer[0] == 's') {
+		if (remcom_in_buffer[0] == 's') {
 			linux_regs->eflags |= 0x100;
 			debugger_step = 1;
 		}
@@ -350,30 +350,30 @@
 		return (0);
 
 	case 'Y':
-		ptr = &remcomInBuffer[1];
-		kgdb_hexToLong(&ptr, &breakno);
+		ptr = &remcom_in_buffer[1];
+		kgdb_hex2long(&ptr, &breakno);
 		ptr++;
-		kgdb_hexToLong(&ptr, &breaktype);
+		kgdb_hex2long(&ptr, &breaktype);
 		ptr++;
-		kgdb_hexToLong(&ptr, &length);
+		kgdb_hex2long(&ptr, &length);
 		ptr++;
-		kgdb_hexToLong(&ptr, &addr);
+		kgdb_hex2long(&ptr, &addr);
 		if (set_hw_break(breakno & 0x3, breaktype & 0x3, 
 				 length & 0x3, addr) == 0) {
-			strcpy(remcomOutBuffer, "OK");
+			strcpy(remcom_out_buffer, "OK");
 		} else {
-			strcpy(remcomOutBuffer, "ERROR");
+			strcpy(remcom_out_buffer, "ERROR");
 		}
 		break;
 
 		/* Remove hardware breakpoint */
 	case 'y':
-		ptr = &remcomInBuffer[1];
-		kgdb_hexToLong(&ptr, &breakno);
+		ptr = &remcom_in_buffer[1];
+		kgdb_hex2long(&ptr, &breakno);
 		if (remove_hw_break(breakno & 0x3) == 0) {
-			strcpy(remcomOutBuffer, "OK");
+			strcpy(remcom_out_buffer, "OK");
 		} else {
-			strcpy(remcomOutBuffer, "ERROR");
+			strcpy(remcom_out_buffer, "ERROR");
 		}
 		break;
 
--- clean-mm/include/linux/kgdb.h	2004-02-22 16:43:42.000000000 +0100
+++ linux-mm/include/linux/kgdb.h	2004-02-22 21:42:55.000000000 +0100
@@ -105,7 +105,7 @@
 
 extern void kgdb8250_add_port(int i, struct uart_port *serial_req);
 
-int kgdb_hexToLong(char **ptr, long *longValue);
+int kgdb_hex2long(char **ptr, long *longValue);
 char *kgdb_mem2hex(char *mem, char *buf, int count);
 char *kgdb_hex2mem(char *buf, char *mem, int count);
 int kgdb_get_mem (char *addr, unsigned char *buf, int count);
--- clean-mm/kernel/kgdbstub.c	2004-02-22 16:43:42.000000000 +0100
+++ linux-mm/kernel/kgdbstub.c	2004-02-22 21:49:11.000000000 +0100
@@ -99,8 +99,8 @@
  */
 gdb_debug_hook *linux_debug_hook;
 
-static char remcomInBuffer[BUFMAX];
-static char remcomOutBuffer[BUFMAX];
+static char remcom_in_buffer[BUFMAX];
+static char remcom_out_buffer[BUFMAX];
 
 /*
  * The following are the stub functions for code which is arch specific
@@ -203,7 +203,7 @@
 }
 
 /* scan for the sequence $<data>#<checksum>	*/
-static void getpacket(char *buffer)
+static void get_packet(char *buffer)
 {
 	unsigned char checksum;
 	unsigned char xmitcsum;
@@ -213,7 +213,8 @@
 
 	do {
 	/* wait around for the start character, ignore all other characters */
-		while ((ch = (kgdb_serial->read_char() & 0x7f)) != '$');
+		while ((ch = (kgdb_serial->read_char() & 0x7f)) != '$')
+			;
 		checksum = 0;
 		xmitcsum = -1;
 
@@ -248,7 +249,7 @@
  * Send the packet in buffer.
  * Check for gdb connection if asked for.
  */
-static void putpacket(char *buffer, int checkconnect)
+static void put_packet(char *buffer, int checkconnect)
 {
 	unsigned char checksum;
 	int count;
@@ -389,7 +390,7 @@
  * While we find nice hex chars, build a longValue.
  * Return number of chars processed.
  */
-int kgdb_hexToLong(char **ptr, long *longValue)
+int kgdb_hex2long(char **ptr, long *longValue)
 {
 	int numChars = 0;
 	int hexValue;
@@ -691,25 +692,25 @@
 	procindebug[smp_processor_id()] = 1;
 
 	/* Clear the out buffer. */
-	memset(remcomOutBuffer, 0, sizeof(remcomOutBuffer));
+	memset(remcom_out_buffer, 0, sizeof(remcom_out_buffer));
 
 	/* Master processor is completely in the debugger */
 	kgdb_post_master_code(linux_regs, exVector, err_code);
 
 	if (atomic_read(&kgdb_killed_or_detached) &&
 	    atomic_read(&kgdb_might_be_resumed)) {
-		getpacket(remcomInBuffer);
-		if(remcomInBuffer[0] == 'H' && remcomInBuffer[1] =='c') {
+		get_packet(remcom_in_buffer);
+		if(remcom_in_buffer[0] == 'H' && remcom_in_buffer[1] =='c') {
 			remove_all_break();
 			atomic_set(&kgdb_killed_or_detached, 0);
-			ok_packet(remcomOutBuffer);
+			ok_packet(remcom_out_buffer);
 		}
 		else
 			return 1;
 	} else {
 
 		/* reply to host that an exception has occurred */
-		ptr = remcomOutBuffer;
+		ptr = remcom_out_buffer;
 		*ptr++ = 'T';
 		*ptr++ = hexchars[(signo >> 4) % 16];
 		*ptr++ = hexchars[signo % 16];
@@ -720,7 +721,7 @@
 		*ptr = '\0';
 	}		
 
-	putpacket(remcomOutBuffer, 0);
+	put_packet(remcom_out_buffer, 0);
 	kgdb_connected = 1;
 	
 	kgdb_usethread = current;
@@ -731,15 +732,15 @@
 		error = 0;
 
 		/* Clear the out buffer. */
-		memset(remcomOutBuffer, 0, sizeof(remcomOutBuffer));
+		memset(remcom_out_buffer, 0, sizeof(remcom_out_buffer));
 
-		getpacket(remcomInBuffer);
+		get_packet(remcom_in_buffer);
 
-		switch (remcomInBuffer[0]) {
+		switch (remcom_in_buffer[0]) {
 		case '?':
-			remcomOutBuffer[0] = 'S';
-			remcomOutBuffer[1] = hexchars[signo >> 4];
-			remcomOutBuffer[2] = hexchars[signo % 16];
+			remcom_out_buffer[0] = 'S';
+			remcom_out_buffer[1] = hexchars[signo >> 4];
+			remcom_out_buffer[2] = hexchars[signo % 16];
 			break;
 
 		case 'g':	/* return the value of the CPU registers */
@@ -757,14 +758,14 @@
 						kgdb_usethreadid - pid_max -
 						num_online_cpus());
 				if (!shadowregs) {
-					error_packet(remcomOutBuffer, -EINVAL);
+					error_packet(remcom_out_buffer, -EINVAL);
 					break;
 				}
 				regs_to_gdb_regs(gdb_regs, shadowregs);
 			} else if (thread->thread.debuggerinfo) {
 				if ((error = get_char(thread->thread.debuggerinfo,
 					(unsigned char *)gdb_regs)) < 0) {
-					error_packet(remcomOutBuffer, error);
+					error_packet(remcom_out_buffer, error);
 					break;
 				}
 				regs_to_gdb_regs(gdb_regs,
@@ -778,50 +779,50 @@
 				sleeping_thread_to_gdb_regs(gdb_regs, thread);
 			}
 				
-			kgdb_mem2hex((char *) gdb_regs, remcomOutBuffer, NUMREGBYTES);
+			kgdb_mem2hex((char *) gdb_regs, remcom_out_buffer, NUMREGBYTES);
 			break;
 
 		case 'G':	/* set the value of the CPU registers - return OK */
-			kgdb_hex2mem(&remcomInBuffer[1], (char *) gdb_regs,
+			kgdb_hex2mem(&remcom_in_buffer[1], (char *) gdb_regs,
 				NUMREGBYTES);
 				
 			if (kgdb_usethread && kgdb_usethread != current)
-				error_packet(remcomOutBuffer, -EINVAL);
+				error_packet(remcom_out_buffer, -EINVAL);
 			else {
 				gdb_regs_to_regs(gdb_regs,
 					(struct pt_regs *)
 					current->thread.debuggerinfo);
-				ok_packet(remcomOutBuffer);
+				ok_packet(remcom_out_buffer);
 			}
 
 			break;
 
 			/* mAA..AA,LLLL  Read LLLL bytes at address AA..AA */
 		case 'm':
-			ptr = &remcomInBuffer[1];
-			if (kgdb_hexToLong(&ptr, &addr) > 0 && *ptr++ == ',' &&
-			    kgdb_hexToLong(&ptr, &length) > 0) {
+			ptr = &remcom_in_buffer[1];
+			if (kgdb_hex2long(&ptr, &addr) > 0 && *ptr++ == ',' &&
+			    kgdb_hex2long(&ptr, &length) > 0) {
 				if (IS_ERR(ptr = kgdb_mem2hex((char *) addr,
-							remcomOutBuffer,
+							remcom_out_buffer,
 							length)))
-					error_packet(remcomOutBuffer,
+					error_packet(remcom_out_buffer,
 							PTR_ERR(ptr));
 			} else
-				error_packet(remcomOutBuffer, -EINVAL);
+				error_packet(remcom_out_buffer, -EINVAL);
 			break;
 
 		/* MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK */
 		case 'M':
-			ptr = &remcomInBuffer[1];
-			if (kgdb_hexToLong(&ptr, &addr) > 0 && *(ptr++) == ','
-				&& kgdb_hexToLong(&ptr, &length) > 0 &&
+			ptr = &remcom_in_buffer[1];
+			if (kgdb_hex2long(&ptr, &addr) > 0 && *(ptr++) == ','
+				&& kgdb_hex2long(&ptr, &length) > 0 &&
 				*(ptr++) == ':') {
 				if (IS_ERR(ptr = kgdb_hex2mem(ptr, (char *)addr,
 							length)))
-					error_packet(remcomOutBuffer,
+					error_packet(remcom_out_buffer,
 							PTR_ERR(ptr));
 			} else
-				error_packet(remcomOutBuffer, -EINVAL);
+				error_packet(remcom_out_buffer, -EINVAL);
 			break;
 
 			/* kill or detach. KGDB should treat this like a 
@@ -829,12 +830,12 @@
 			 */
 		case 'D':
 			if ((error = remove_all_break()) < 0) {
-				error_packet(remcomOutBuffer, error);
+				error_packet(remcom_out_buffer, error);
 			} else {
-				ok_packet(remcomOutBuffer);
+				ok_packet(remcom_out_buffer);
 				kgdb_connected = 0;
 			}
-			putpacket(remcomOutBuffer, 0);
+			put_packet(remcom_out_buffer, 0);
 			goto default_handle;
 
 		case 'k':
@@ -845,20 +846,20 @@
 
 			/* query */
 		case 'q':
-			switch (remcomInBuffer[1]) {
+			switch (remcom_in_buffer[1]) {
 			case 's':
 			case 'f':
-				if (memcmp(remcomInBuffer+2, "ThreadInfo",10))
+				if (memcmp(remcom_in_buffer+2, "ThreadInfo",10))
 				{
-					error_packet(remcomOutBuffer,
+					error_packet(remcom_out_buffer,
 							-EINVAL);
 					break;
 				}
-				if (remcomInBuffer[1] == 'f') {
+				if (remcom_in_buffer[1] == 'f') {
 					threadid = 1;
 				}
-				remcomOutBuffer[0] = 'm';
-				ptr = remcomOutBuffer + 1;
+				remcom_out_buffer[0] = 'm';
+				ptr = remcom_out_buffer + 1;
 				for (i = 0; i < 32 && threadid < pid_max +
 						numshadowth; threadid++) {
 					thread = getthread(linux_regs,
@@ -877,48 +878,48 @@
 
 			case 'C':
 				/* Current thread id */
-				strcpy(remcomOutBuffer, "QC");
+				strcpy(remcom_out_buffer, "QC");
 
 				threadid = shadow_pid(current->pid);
 				
 				int_to_threadref(&thref, threadid);
-				pack_threadid(remcomOutBuffer + 2, &thref);
+				pack_threadid(remcom_out_buffer + 2, &thref);
 				break;
 
 			case 'E':
 				/* Print exception info */
 				kgdb_printexceptioninfo(exVector, err_code,
-						remcomOutBuffer);
+						remcom_out_buffer);
 				break;
 			case 'T':
-				if (memcmp(remcomInBuffer+1,
+				if (memcmp(remcom_in_buffer+1,
 					"ThreadExtraInfo,",16))
 				{
-					error_packet(remcomOutBuffer, -EINVAL);
+					error_packet(remcom_out_buffer, -EINVAL);
 					break;
 				}
 				threadid = 0;
-				ptr = remcomInBuffer+17;
-				kgdb_hexToLong(&ptr, &threadid);
+				ptr = remcom_in_buffer+17;
+				kgdb_hex2long(&ptr, &threadid);
 				if (!getthread(linux_regs, threadid)) {
-					error_packet(remcomOutBuffer, -EINVAL);
+					error_packet(remcom_out_buffer, -EINVAL);
 					break;
 				}
 				if (threadid < pid_max) {
 					kgdb_mem2hex(getthread(linux_regs,
 						threadid)->comm,
-						remcomOutBuffer, 16);
+						remcom_out_buffer, 16);
 				} else if (threadid >= pid_max +
 						num_online_cpus()) {
 					kgdb_shadowinfo(linux_regs,
-						remcomOutBuffer,
+						remcom_out_buffer,
 						threadid - pid_max -
 						num_online_cpus());
 				} else {
 					sprintf(tmpstr, "Shadow task %d"
 						" for pid 0",
 						(int)(threadid - pid_max));
-					kgdb_mem2hex(tmpstr, remcomOutBuffer,
+					kgdb_mem2hex(tmpstr, remcom_out_buffer,
 							strlen(tmpstr));
 				}
 				break;
@@ -927,60 +928,60 @@
 
 			/* task related */
 		case 'H':
-			switch (remcomInBuffer[1]) {
+			switch (remcom_in_buffer[1]) {
 			case 'g':
-				ptr = &remcomInBuffer[2];
-				kgdb_hexToLong(&ptr, &threadid);
+				ptr = &remcom_in_buffer[2];
+				kgdb_hex2long(&ptr, &threadid);
 				thread = getthread(linux_regs, threadid);
 				if (!thread && threadid > 0) {
-					error_packet(remcomOutBuffer, -EINVAL);
+					error_packet(remcom_out_buffer, -EINVAL);
 					break;
 				}
 				kgdb_usethread = thread;
 				kgdb_usethreadid = threadid;
-				ok_packet(remcomOutBuffer);
+				ok_packet(remcom_out_buffer);
 				break;
 
 			case 'c':
 				atomic_set(&kgdb_killed_or_detached, 0);
-				ptr = &remcomInBuffer[2];
-				kgdb_hexToLong(&ptr, &threadid);
+				ptr = &remcom_in_buffer[2];
+				kgdb_hex2long(&ptr, &threadid);
 				if (!threadid) {
 					kgdb_contthread = 0;
 				} else {
 					thread = getthread(linux_regs, threadid);
 					if (!thread && threadid > 0) {
-						error_packet(remcomOutBuffer,
+						error_packet(remcom_out_buffer,
 								-EINVAL);
 						break;
 					}
 					kgdb_contthread = thread;
 				}
-				ok_packet(remcomOutBuffer);
+				ok_packet(remcom_out_buffer);
 				break;
 			}
 			break;
 
 			/* Query thread status */
 		case 'T':
-			ptr = &remcomInBuffer[1];
-			kgdb_hexToLong(&ptr, &threadid);
+			ptr = &remcom_in_buffer[1];
+			kgdb_hex2long(&ptr, &threadid);
 			thread = getthread(linux_regs, threadid);
 			if (thread)
-				ok_packet(remcomOutBuffer);
+				ok_packet(remcom_out_buffer);
 			else
-				error_packet(remcomOutBuffer, -EINVAL);
+				error_packet(remcom_out_buffer, -EINVAL);
 			break;
 		case 'z':
 		case 'Z':
-			ptr = &remcomInBuffer[2];
+			ptr = &remcom_in_buffer[2];
 			if (*(ptr++) != ',') {
-				error_packet(remcomOutBuffer, -EINVAL);
+				error_packet(remcom_out_buffer, -EINVAL);
 				break;
 			}
-			kgdb_hexToLong(&ptr, &addr);
+			kgdb_hex2long(&ptr, &addr);
 			
-			bpt_type = remcomInBuffer[1];
+			bpt_type = remcom_in_buffer[1];
 			if (bpt_type != bp_breakpoint) {
 				if (bpt_type == bp_hardware_breakpoint && 
 				    !(kgdb_ops->flags & KGDB_HW_BREAKPOINT))
@@ -993,7 +994,7 @@
 					break;
 			}
 			
-			if (remcomInBuffer[0] == 'Z') {
+			if (remcom_in_buffer[0] == 'Z') {
 				if (bpt_type == bp_breakpoint)
 					error = set_break(addr);
 				else
@@ -1009,27 +1010,27 @@
 			}
 			
 			if (error == 0)
-				ok_packet(remcomOutBuffer);
+				ok_packet(remcom_out_buffer);
 			else
-				error_packet(remcomOutBuffer, error);
+				error_packet(remcom_out_buffer, error);
 			
 			break;
 
 		default:
 		default_handle:
 			error = kgdb_arch_handle_exception(exVector, signo,
-					err_code, remcomInBuffer,
-					remcomOutBuffer, linux_regs);
+					err_code, remcom_in_buffer,
+					remcom_out_buffer, linux_regs);
 
-			if(error >= 0 || remcomInBuffer[0] == 'D' ||
-			    remcomInBuffer[0] == 'k')
+			if(error >= 0 || remcom_in_buffer[0] == 'D' ||
+			    remcom_in_buffer[0] == 'k')
 				goto kgdb_exit;
 
 
 		} /* switch */
 
 		/* reply to the request */
-		putpacket(remcomOutBuffer, 0);
+		put_packet(remcom_out_buffer, 0);
 	}
 
 kgdb_exit:
@@ -1189,7 +1190,7 @@
 		*bufptr = '\0';
 		s += wcount;
 
-		putpacket(kgdbconbuf, 1);
+		put_packet(kgdbconbuf, 1);
 
 	}
 	local_irq_restore(flags);

--RnlQjJ0d97Da+TV1--
