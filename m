Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317751AbSIJSJF>; Tue, 10 Sep 2002 14:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSIJSJE>; Tue, 10 Sep 2002 14:09:04 -0400
Received: from nameservices.net ([208.234.25.16]:960 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S317751AbSIJSI0>;
	Tue, 10 Sep 2002 14:08:26 -0400
Message-ID: <3D7E36F3.15E97907@opersys.com>
Date: Tue, 10 Sep 2002 14:16:19 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] 2/8 LTT for 2.5.34: Trace driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is LTT's trace driver. This patch adds the following files:
drivers/trace/Config.help
drivers/trace/Config.in
drivers/trace/tracer.c
drivers/trace/tracer.h

The trace driver uses the rvmalloc/rvfree couple to allocate a mem
region it can remap to the daemon's address space.

diff -urN linux-2.5.34/drivers/Makefile linux-2.5.34-ltt/drivers/Makefile
--- linux-2.5.34/drivers/Makefile	Mon Sep  9 13:35:15 2002
+++ linux-2.5.34-ltt/drivers/Makefile	Mon Sep  9 19:06:34 2002
@@ -41,5 +41,6 @@
 obj-$(CONFIG_BLUEZ)		+= bluetooth/
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_ISDN_BOOL)		+= isdn/
+obj-$(CONFIG_TRACE)		+= trace/
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.5.34/drivers/trace/Config.help linux-2.5.34-ltt/drivers/trace/Config.help
--- linux-2.5.34/drivers/trace/Config.help	Wed Dec 31 19:00:00 1969
+++ linux-2.5.34-ltt/drivers/trace/Config.help	Mon Sep  9 19:06:34 2002
@@ -0,0 +1,36 @@
+Kernel events tracing support
+CONFIG_TRACE
+  It is possible for the kernel to log important events to a tracing
+  driver. Doing so, enables the use of the generated traces in order
+  to reconstruct the dynamic behavior of the kernel, and hence the
+  whole system.
+
+  The tracing process contains 4 parts :
+      1) The logging of events by key parts of the kernel.
+      2) The trace driver that keeps the events in a data buffer.
+      3) A trace daemon that opens the trace driver and is notified
+         every time there is a certain quantity of data to read
+         from the trace driver (using SIG_IO).
+      4) A trace event data decoder that reads the accumulated data
+         and formats it in a human-readable format.
+
+  If you say Y or M here, the first part of the tracing process will
+  always take place. That is, critical parts of the kernel will call
+  upon the kernel tracing function. The data generated doesn't go
+  any further until a trace driver registers himself as such with the
+  kernel. Therefore, if you answer Y, then the driver will be part of
+  the kernel and the events will always proceed onto the driver and
+  if you say M, then the events will only proceed onto the driver when
+  it's module is loaded. Note that event's aren't logged in the driver
+  until the profiling daemon opens the device, configures it and
+  issues the "start" command through ioctl().
+
+  The impact of a fully functionnal system (kernel event logging +
+  driver event copying + active trace daemon) is of 2.5% for core events.
+  This means that for a task that took 100 seconds on a normal system, it
+  will take 102.5 seconds on a traced system. This is very low compared
+  to other profiling or tracing methods.
+
+  For more information on kernel tracing, the trace daemon or the event
+  decoder, please check the following address :
+       http://www.opersys.com/LTT
diff -urN linux-2.5.34/drivers/trace/Config.in linux-2.5.34-ltt/drivers/trace/Config.in
--- linux-2.5.34/drivers/trace/Config.in	Wed Dec 31 19:00:00 1969
+++ linux-2.5.34-ltt/drivers/trace/Config.in	Mon Sep  9 19:06:34 2002
@@ -0,0 +1,4 @@
+mainmenu_option next_comment
+comment 'Kernel tracing'
+tristate 'Kernel events tracing support' CONFIG_TRACE
+endmenu
diff -urN linux-2.5.34/drivers/trace/Makefile linux-2.5.34-ltt/drivers/trace/Makefile
--- linux-2.5.34/drivers/trace/Makefile	Wed Dec 31 19:00:00 1969
+++ linux-2.5.34-ltt/drivers/trace/Makefile	Mon Sep  9 19:06:34 2002
@@ -0,0 +1,17 @@
+#
+# Makefile for the kernel tracing drivers.
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definitions are now inherited from the
+# parent makes..
+#
+
+O_TARGET := built-in.o
+
+# Is it loaded as a module or as part of the kernel
+obj-$(CONFIG_TRACE) = tracer.o
+
+include $(TOPDIR)/Rules.make
diff -urN linux-2.5.34/drivers/trace/tracer.c linux-2.5.34-ltt/drivers/trace/tracer.c
--- linux-2.5.34/drivers/trace/tracer.c	Wed Dec 31 19:00:00 1969
+++ linux-2.5.34-ltt/drivers/trace/tracer.c	Tue Sep 10 01:18:53 2002
@@ -0,0 +1,1308 @@
+/*
+ * linux/drivers/trace/tracer.c
+ *
+ * (C) Copyright, 1999, 2000, 2001, 2002 - Karim Yaghmour (karim@opersys.com)
+ *
+ * Contains the code for the kernel tracing driver (tracer for short).
+ *
+ * Author:
+ *    Karim Yaghmour (karim@opersys.com)
+ *
+ * Changelog:
+ *    03/12/01, Added user event support.
+ *    05/01/01, Modified PPC bit manipulation functions for x86 compatibility.
+ *              (andy_lowe@mvista.com)
+ *    15/11/00, Finally fixed memory allocation and remapping method. Now using
+ *              BTTV-driver-inspired code.
+ *    13/03/00, Modified tracer so that the daemon mmaps the tracer's buffers
+ *              in it's address space rather than use "read".
+ *    26/01/00, Added support for standardized buffer sizes and extensibility
+ *              of events.
+ *    01/10/99, Modified tracer in order to used double-buffering.
+ *    28/09/99, Adding tracer configuration support.
+ *    09/09/99, Chaging the format of an event record in order to reduce the
+ *              size of the traces.
+ *    04/03/99, Initial typing.
+ *
+ * Note:
+ *    The sizes of the variables used to store the details of an event are
+ *    planned for a system who gets at least one clock tick every 10 
+ *    milli-seconds. There has to be at least one event every 2^32-1
+ *    microseconds, otherwise the size of the variable holding the time doesn't
+ *    work anymore.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+
+#include <linux/fs.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/trace.h>
+#include <linux/wrapper.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+
+#include <asm/io.h>
+#include <asm/current.h>
+#include <asm/uaccess.h>
+#include <asm/bitops.h>
+#include <asm/pgtable.h>
+#include <asm/trace.h>
+
+#include "tracer.h"
+
+/* Module information */
+MODULE_AUTHOR("Karim Yaghmour (karim@opersys.com)");
+MODULE_DESCRIPTION("Linux Trace Toolkit (LTT) kernel tracing driver");
+MODULE_LICENSE("GPL");
+
+/*  Driver */
+static int		sMajorNumber;		/* Major number of the tracer */
+static int		sOpenCount;		/* Number of times device is open */
+/*  Locking */
+static int		sTracLock;		/* Tracer lock used to lock primary buffer */
+static spinlock_t 	sSpinLock;		/* Spinlock in order to lock kernel */
+/*  Daemon */
+static int 		sSignalSent;		/* A signal has been sent to the daemon */
+static struct task_struct* sDaemonTaskStruct;	/* Task structure of the tracer daemon */
+/*  Tracer configuration */
+static int		sTracerStarted;		/* Is the tracer started */
+static trace_event_mask	sTracedEvents;		/* Bit-field of events being traced */
+static trace_event_mask	sLogEventDetailsMask;	/* Log the details of the events mask */
+static int		sLogCPUID;		/* Log the CPUID associated with each event */
+static int		sUseSyscallEIPBounds;	/* Use adress bounds to fetch the EIP where call is made */
+static int		sLowerEIPBoundSet;	/* The lower bound EIP has been set */
+static int		sUpperEIPBoundSet;	/* The upper bound EIP has been set */
+static void*		sLowerEIPBound;		/* The lower bound EIP */
+static void*		sUpperEIPBound;		/* The upper bound EIP */
+static int		sTracingPID;		/* Tracing only the events for one pid */
+static int		sTracingPGRP;		/* Tracing only the events for one process group */
+static int		sTracingGID;		/* Tracing only the events for one gid */
+static int		sTracingUID;		/* Tracing only the events for one uid */
+static pid_t		sTracedPID;		/* PID being traced */
+static pid_t		sTracedPGRP;		/* Process group being traced */
+static gid_t		sTracedGID;		/* GID being traced */
+static uid_t		sTracedUID;		/* UID being traced */
+static int		sSyscallEIPDepthSet;	/* The call depth at which to fetch EIP has been set */
+static int		sSyscallEIPDepth;	/* The call depth at which to fetch the EIP */
+/*  Event data buffers */
+static int		sBufReadComplete;	/* Number of buffers completely filled */
+static int		sSizeReadIncomplete;	/* Quantity of data read from incomplete buffers */
+static int		sEventsLost;		/* Number of events lost because of lack of buffer space */
+static u32		sBufSize;		/* Buffer sizes */
+static u32		sAllocSize;		/* Size of buffers allocated */
+static u32		sBufferID;		/* Unique buffer ID */
+static char*		sTracBuf = NULL;	/* Trace buffer */
+static char*		sWritBuf = NULL;	/* Buffer used for writting */
+static char*		sReadBuf = NULL;	/* Buffer used for reading */
+static char*		sWritBufEnd;		/* End of write buffer */
+static char*		sReadBufEnd;		/* End of read buffer */
+static char*		sWritPos;		/* Current position for writting */
+static char*		sReadLimit;		/* Limit at which read should stop */
+static char*		sWritLimit;		/* Limit at which write should stop */
+
+/*  Time */
+static struct timeval sBufferStartTime;		/* The time at which the buffer was started */
+
+/*  Large data components allocated at load time */
+static char *sUserEventData = NULL;		/* The data associated with a user event */
+
+
+/* The size of the structures used to describe the events */
+static int sEventStructSize[TRACE_EV_MAX + 1] =
+{
+	sizeof(trace_start)		/* TRACE_START */ ,
+	sizeof(trace_syscall_entry)	/* TRACE_SYSCALL_ENTRY */ ,
+	0				/* TRACE_SYSCALL_EXIT */ ,
+	sizeof(trace_trap_entry)	/* TRACE_TRAP_ENTRY */ ,
+	0				/* TRACE_TRAP_EXIT */ ,
+	sizeof(trace_irq_entry)		/* TRACE_IRQ_ENTRY */ ,
+	0				/* TRACE_IRQ_EXIT */ ,
+	sizeof(trace_schedchange)	/* TRACE_SCHEDCHANGE */ ,
+	0				/* TRACE_KERNEL_TIMER */ ,
+	sizeof(trace_soft_irq)		/* TRACE_SOFT_IRQ */ ,
+	sizeof(trace_process)		/* TRACE_PROCESS */ ,
+	sizeof(trace_file_system)	/* TRACE_FILE_SYSTEM */ ,
+	sizeof(trace_timer)		/* TRACE_TIMER */ ,
+	sizeof(trace_memory)		/* TRACE_MEMORY */ ,
+	sizeof(trace_socket)		/* TRACE_SOCKET */ ,
+	sizeof(trace_ipc)		/* TRACE_IPC */ ,
+	sizeof(trace_network)		/* TRACE_NETWORK */ ,
+	sizeof(trace_buffer_start)	/* TRACE_BUFFER_START */ ,
+	0				/* TRACE_BUFFER_END */ ,
+	sizeof(trace_new_event)		/* TRACE_NEW_EVENT */ ,
+	sizeof(trace_custom)		/* TRACE_CUSTOM */ ,
+	sizeof(trace_change_mask)	/* TRACE_CHANGE_MASK */
+};
+
+/* The file operations available for the tracer */
+static struct file_operations sTracerFileOps =
+{
+	owner:		THIS_MODULE,
+	ioctl:		tracer_ioctl,
+	mmap:		tracer_mmap,
+	open:		tracer_open,
+	release:	tracer_release,
+	fsync:		tracer_fsync,
+};
+
+/* This inspired by rtai/shmem */
+#define FIX_SIZE(x) (((x) - 1) & PAGE_MASK) + PAGE_SIZE
+
+/* \begin{Code inspired from BTTV driver} */
+
+/* Here we want the physical address of the memory.
+ * This is used when initializing the contents of the
+ * area and marking the pages as reserved.
+ */
+static inline unsigned long kvirt_to_pa(unsigned long adr)
+{
+	unsigned long kva, ret;
+
+	kva = (unsigned long) page_address(vmalloc_to_page((void *) adr));
+	kva |= adr & (PAGE_SIZE - 1);	/* restore the offset */
+	ret = __pa(kva);
+	return ret;
+}
+
+static void *rvmalloc(unsigned long size)
+{
+	void *mem;
+	unsigned long adr;
+
+	mem = vmalloc_32(size);
+	if (!mem)
+		return NULL;
+
+	memset(mem, 0, size);	/* Clear the ram out, no junk to the user */
+	adr = (unsigned long) mem;
+	while (size > 0) {
+		mem_map_reserve(vmalloc_to_page((void *) adr));
+		adr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+
+	return mem;
+}
+
+static void rvfree(void *mem, unsigned long size)
+{
+	unsigned long adr;
+
+	if (!mem)
+		return;
+
+	adr = (unsigned long) mem;
+	while ((long) size > 0) {
+		mem_map_unreserve(vmalloc_to_page((void *) adr));
+		adr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+	vfree(mem);
+}
+
+static int tracer_mmap_region(struct vm_area_struct *vma,
+			      const char *adr,
+			      const char *start_pos,
+			      unsigned long size)
+{
+	unsigned long start = (unsigned long) adr;
+	unsigned long page, pos;
+
+	pos = (unsigned long) start_pos;
+	while (size > 0) {
+		page = kvirt_to_pa(pos);
+		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
+			return -EAGAIN;
+		start += PAGE_SIZE;
+		pos += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+	return 0;
+}
+/* \end{Code inspired from BTTV driver} */
+
+/**
+ *	tracer_write_to_buffer: - Write data to destination buffer
+ *
+ *	Writes data to the destination buffer and updates the begining the
+ *	buffer write position.
+ */
+#define tracer_write_to_buffer(DEST, SRC, SIZE) \
+do\
+{\
+   memcpy(DEST, SRC, SIZE);\
+   DEST += SIZE;\
+} while(0);
+
+/**
+ *	trace: - Tracing function per se.
+ *	@pmEventID: ID of event as defined in linux/trace.h
+ *	@pmEventStruct: struct describing the event
+ *
+ *	Returns: 
+ *	0, if everything went OK (event got registered)
+ *	-ENODEV, no tracing daemon opened the driver.
+ *	-ENOMEM, no more memory to store events.
+ *	-EBUSY, tracer not started yet.
+ *
+ *	Note:
+ *	The kernel has to be locked here because trace() could be called from
+ *	an interrupt handling routine and from process service routine.
+ */
+int trace(u8 pmEventID,
+	  void *pmEventStruct)
+{
+	int lVarDataLen = 0;		/* Length of variable length data to be copied, if any */
+	void *lVarDataBeg = NULL;	/* Begining of variable length data to be copied */
+	int lSendSignal = FALSE;	/* Should the daemon be summoned */
+	u8 lCPUID;			/* CPUID of currently runing process */
+	uint16_t lDataSize;		/* Size of tracing data */
+	struct siginfo lSigInfo;	/* Signal information */
+	struct timeval lTime;		/* Event time */
+	unsigned long int lFlags;	/* CPU flags for lock */
+	trace_time_delta lTimeDelta;	/* The time elapsed between now and the last event */
+	struct task_struct *pIncomingProcess = NULL;	/* Pointer to incoming process */
+
+	/* Is there a tracing daemon */
+	if (sDaemonTaskStruct == NULL)
+		return -ENODEV;
+
+	/* Is this the exit of a process? */
+	if ((pmEventID == TRACE_EV_PROCESS) &&
+	    (pmEventStruct != NULL) &&
+	    ((((trace_process *) pmEventStruct)->event_sub_id) == TRACE_EV_PROCESS_EXIT))
+		trace_destroy_owners_events(current->pid);
+
+	/* Do we trace the event */
+	if ((sTracerStarted == TRUE) || (pmEventID == TRACE_EV_START) || (pmEventID == TRACE_EV_BUFFER_START))
+		goto TraceEvent;
+
+	return -EBUSY;
+
+TraceEvent:
+	/* Are we monitoring this event */
+	if (!ltt_test_bit(pmEventID, &sTracedEvents))
+		return 0;
+
+	/* Always let the start event pass, whatever the IDs */
+	if ((pmEventID != TRACE_EV_START) && (pmEventID != TRACE_EV_BUFFER_START)) {
+		/* Is this a scheduling change */
+		if (pmEventID == TRACE_EV_SCHEDCHANGE) {
+			/* Get pointer to incoming process */
+			pIncomingProcess = (struct task_struct *) (((trace_schedchange *) pmEventStruct)->in);
+
+			/* Set PID information in schedchange event */
+			(((trace_schedchange *) pmEventStruct)->in) = pIncomingProcess->pid;
+		}
+		/* Are we monitoring a particular process */
+		if ((sTracingPID == TRUE) && (current->pid != sTracedPID)) {
+			/* Record this event if it is the scheduling change bringing in the traced PID */
+			if (pIncomingProcess == NULL)
+				return 0;
+			else if (pIncomingProcess->pid != sTracedPID)
+				return 0;
+		}
+		/* Are we monitoring a particular process group */
+		if ((sTracingPGRP == TRUE) && (current->pgrp != sTracedPGRP)) {
+			/* Record this event if it is the scheduling change bringing in a process of the traced PGRP */
+			if (pIncomingProcess == NULL)
+				return 0;
+			else if (pIncomingProcess->pgrp != sTracedPGRP)
+				return 0;
+		}
+		/* Are we monitoring the processes of a given group of users */
+		if ((sTracingGID == TRUE) && (current->egid != sTracedGID)) {
+			/* Record this event if it is the scheduling change bringing in a process of the traced GID */
+			if (pIncomingProcess == NULL)
+				return 0;
+			else if (pIncomingProcess->egid != sTracedGID)
+				return 0;
+		}
+		/* Are we monitoring the processes of a given user */
+		if ((sTracingUID == TRUE) && (current->euid != sTracedUID)) {
+			/* Record this event if it is the scheduling change bringing in a process of the traced UID */
+			if (pIncomingProcess == NULL)
+				return 0;
+			else if (pIncomingProcess->euid != sTracedUID)
+				return 0;
+		}
+	}
+	/* Compute size of tracing data */
+	lDataSize = sizeof(pmEventID) + sizeof(lTimeDelta) + sizeof(lDataSize);
+
+	/* Do we log the event details */
+	if (ltt_test_bit(pmEventID, &sLogEventDetailsMask)) {
+		/* Update the size of the data entry */
+		lDataSize += sEventStructSize[pmEventID];
+
+		/* Some events have variable length */
+		switch (pmEventID) {
+		/* Is there a file name in this */
+		case TRACE_EV_FILE_SYSTEM:
+			if ((((trace_file_system *) pmEventStruct)->event_sub_id == TRACE_EV_FILE_SYSTEM_EXEC)
+			    || (((trace_file_system *) pmEventStruct)->event_sub_id == TRACE_EV_FILE_SYSTEM_OPEN)) {
+				/* Remember the string's begining and update size variables */
+				lVarDataBeg = ((trace_file_system *) pmEventStruct)->file_name;
+				lVarDataLen = ((trace_file_system *) pmEventStruct)->event_data2 + 1;
+				lDataSize += (uint16_t) lVarDataLen;
+			}
+			break;
+
+		/* Logging of a custom event */
+		case TRACE_EV_CUSTOM:
+			lVarDataBeg = ((trace_custom *) pmEventStruct)->data;
+			lVarDataLen = ((trace_custom *) pmEventStruct)->data_size;
+			lDataSize += (uint16_t) lVarDataLen;
+			break;
+		}
+	}
+	/* Do we record the CPUID */
+	if ((sLogCPUID == TRUE) && (pmEventID != TRACE_EV_START) && (pmEventID != TRACE_EV_BUFFER_START)) {
+		/* Remember the CPUID */
+		lCPUID = smp_processor_id();
+
+		/* Update the size of the data entry */
+		lDataSize += sizeof(lCPUID);
+	}
+	/* Lock the kernel */
+	spin_lock_irqsave(&sSpinLock, lFlags);
+
+	/* The following time calculations have to be done within the spinlock because
+	   otherwise the event order could be inverted. */
+
+	/* Get the time of the event */
+	do_gettimeofday(&lTime);
+
+	/* Compute the time delta between this event and the time at which this buffer was started */
+	lTimeDelta = (lTime.tv_sec - sBufferStartTime.tv_sec) * 1000000
+	    + (lTime.tv_usec - sBufferStartTime.tv_usec);
+
+	/* Is there enough space left in the write buffer */
+	if (sWritPos + lDataSize > sWritLimit) {
+		/* Have we already switched buffers and informed the daemon of it */
+		if (sSignalSent == TRUE) {
+			/* We've lost another event */
+			sEventsLost++;
+
+			/* Bye, bye, now */
+			spin_unlock_irqrestore(&sSpinLock, lFlags);
+			return -ENOMEM;
+		}
+		/* We need to inform the daemon */
+		lSendSignal = TRUE;
+
+		/* Switch buffers */
+		tracer_switch_buffers(lTime);
+
+		/* Recompute the time delta since sBufferStartTime has changed because of the buffer change */
+		lTimeDelta = (lTime.tv_sec - sBufferStartTime.tv_sec) * 1000000
+		    + (lTime.tv_usec - sBufferStartTime.tv_usec);
+	}
+	/* Write the CPUID to the tracing buffer, if required */
+	if ((sLogCPUID == TRUE) && (pmEventID != TRACE_EV_START) && (pmEventID != TRACE_EV_BUFFER_START))
+		tracer_write_to_buffer(sWritPos,
+				       &lCPUID,
+				       sizeof(lCPUID));
+
+	/* Write event type to tracing buffer */
+	tracer_write_to_buffer(sWritPos,
+			       &pmEventID,
+			       sizeof(pmEventID));
+
+	/* Write event time delta to tracing buffer */
+	tracer_write_to_buffer(sWritPos,
+			       &lTimeDelta,
+			       sizeof(lTimeDelta));
+
+	/* Do we log event details */
+	if (ltt_test_bit(pmEventID, &sLogEventDetailsMask)) {
+		/* Write event structure */
+		tracer_write_to_buffer(sWritPos,
+				       pmEventStruct,
+				       sEventStructSize[pmEventID]);
+
+		/* Write string if any */
+		if (lVarDataLen)
+			tracer_write_to_buffer(sWritPos,
+					       lVarDataBeg,
+					       lVarDataLen);
+	}
+	/* Write the length of the event description */
+	tracer_write_to_buffer(sWritPos,
+			       &lDataSize,
+			       sizeof(lDataSize));
+
+	/* Should the tracing daemon be notified  */
+	if (lSendSignal == TRUE) {
+		/* Remember that a signal has been sent */
+		sSignalSent = TRUE;
+
+		/* Unlock the kernel */
+		spin_unlock_irqrestore(&sSpinLock, lFlags);
+
+		/* Setup signal information */
+		lSigInfo.si_signo = SIGIO;
+		lSigInfo.si_errno = 0;
+		lSigInfo.si_code = SI_KERNEL;
+
+		/* DEBUG */
+#if 0
+		printk("<1> Sending SIGIO to %d \n", sDaemonTaskStruct->pid);
+#endif
+
+		/* Signal the tracing daemon */
+		send_sig_info(SIGIO, &lSigInfo, sDaemonTaskStruct);
+	} else
+		/* Unlock the kernel */
+		spin_unlock_irqrestore(&sSpinLock, lFlags);
+
+	return 0;
+}
+
+/**
+ *	tracer_switch_buffers: - Switches between read and write buffers.
+ *	@pmTime: current time.
+ *
+ *	Put the current write buffer to be read and reset put the old read
+ *	buffer to be written to. Set the tracer variables in consequence.
+ *
+ *	No return values.
+ *
+ *	This should be called from within a spin_lock.
+ */
+void tracer_switch_buffers(struct timeval pmTime)
+{
+	char *lTempBuf;			/* Temporary buffer pointer */
+	char *lTempBufEnd;		/* Temporary buffer end pointer */
+	char *lInitWritPos;		/* Initial write position */
+	u8 lEventID;			/* Event ID of last event */
+	u8 lCPUID;			/* CPUID of currently runing process */
+	uint16_t lDataSize;		/* Size of tracing data */
+	u32 lSizeLost;			/* Size delta between last event and end of buffer */
+	trace_time_delta lTimeDelta;	/* The time elapsed between now and the last event */
+	trace_buffer_start lStartBufferEvent;	/* Start of the new buffer event */
+
+	/* Remember initial write position */
+	lInitWritPos = sWritPos;
+
+	/* Write the end event at the write of the buffer */
+
+	/* Write the CPUID to the tracing buffer, if required */
+	if (sLogCPUID == TRUE) {
+		lCPUID = smp_processor_id();
+		tracer_write_to_buffer(sWritPos,
+				       &lCPUID,
+				       sizeof(lCPUID));
+	}
+	/* Write event type to tracing buffer */
+	lEventID = TRACE_EV_BUFFER_END;
+	tracer_write_to_buffer(sWritPos,
+			       &lEventID,
+			       sizeof(lEventID));
+
+	/* Write event time delta to tracing buffer */
+	lTimeDelta = 0;
+	tracer_write_to_buffer(sWritPos,
+			       &lTimeDelta,
+			       sizeof(lTimeDelta));
+
+	/* Get size lost */
+	lSizeLost = sWritBufEnd - lInitWritPos;
+
+	/* Write size lost at the end of the buffer */
+	*((u32 *) (sWritBufEnd - sizeof(lSizeLost))) = lSizeLost;
+
+	/* Switch buffers */
+	lTempBuf = sReadBuf;
+	sReadBuf = sWritBuf;
+	sWritBuf = lTempBuf;
+
+	/* Set buffer ends */
+	lTempBufEnd = sReadBufEnd;
+	sReadBufEnd = sWritBufEnd;
+	sWritBufEnd = lTempBufEnd;
+
+	/* Set read limit */
+	sReadLimit = sReadBufEnd;
+
+	/* Set write limit */
+	sWritLimit = sWritBufEnd - TRACER_LAST_EVENT_SIZE;
+
+	/* Set write position */
+	sWritPos = sWritBuf;
+
+	/* Increment buffer ID */
+	sBufferID++;
+
+	/* Set the time of begining of this buffer */
+	sBufferStartTime = pmTime;
+
+	/* Write the start of buffer event */
+	lStartBufferEvent.ID = sBufferID;
+	lStartBufferEvent.Time = pmTime;
+
+	/* Write event type to tracing buffer */
+	lEventID = TRACE_EV_BUFFER_START;
+	tracer_write_to_buffer(sWritPos,
+			       &lEventID,
+			       sizeof(lEventID));
+
+	/* Write event time delta to tracing buffer */
+	lTimeDelta = 0;
+	tracer_write_to_buffer(sWritPos,
+			       &lTimeDelta,
+			       sizeof(lTimeDelta));
+
+	/* Write event structure */
+	tracer_write_to_buffer(sWritPos,
+			       &lStartBufferEvent,
+			       sizeof(lStartBufferEvent));
+
+	/* Compute the data size */
+	lDataSize = sizeof(lEventID)
+	    + sizeof(lTimeDelta)
+	    + sizeof(lStartBufferEvent)
+	    + sizeof(lDataSize);
+
+	/* Write the length of the event description */
+	tracer_write_to_buffer(sWritPos,
+			       &lDataSize,
+			       sizeof(lDataSize));
+}
+
+/**
+ *	tracer_ioctl: - "Ioctl" file op
+ *
+ *	@pmInode: the inode associated with the device
+ *	@pmFile: file structure given to the acting process
+ *	@pmCmd: command given by the caller
+ *	@pmArg: arguments to the command
+ *
+ *	Returns:
+ *	>0, In case the caller requested the number of events lost.
+ *	0, Everything went OK
+ *	-ENOSYS, no such command
+ *	-EINVAL, tracer not properly configured
+ *	-EBUSY, tracer can't be reconfigured while in operation
+ *	-ENOMEM, no more memory
+ *	-EFAULT, unable to access user space memory
+ *
+ *	Note:
+ *	In the future, this function should check to make sure that it's the
+ *	server that make thes ioctl.
+ */
+int tracer_ioctl(struct inode *pmInode,
+		 struct file *pmFile,
+		 unsigned int pmCmd,
+		 unsigned long pmArg)
+{
+	int lRetValue;			/* Function return value */
+	int lDevMinor;			/* Device minor number */
+	int lNewUserEventID;		/* ID of newly created user event */
+	trace_start lStartEvent;	/* Event marking the begining of the trace */
+	unsigned long int lFlags;	/* CPU flags for lock */
+	trace_custom lUserEvent;	/* The user event to be logged */
+	trace_change_mask lTraceMask;	/* Event mask */
+	trace_new_event lNewUserEvent;	/* The event to be created for the user */
+	trace_buffer_start lStartBufferEvent;	/* Start of the new buffer event */
+
+#if 0
+	printk("Tracer: Command %d \n", pmCmd);
+#endif
+
+	/* Get device's minor number */
+	lDevMinor = minor(pmInode->i_rdev) & 0x0f;
+
+	/* If the tracer is started, the daemon can't modify the configuration */
+	if ((lDevMinor == 0)
+	    && (sTracerStarted == TRUE) && (pmCmd != TRACER_STOP) && (pmCmd != TRACER_DATA_COMITTED))
+		return -EBUSY;
+
+	/* Only some operations are permitted to user processes trying to log events */
+	if ((lDevMinor == 1)
+	    && (pmCmd != TRACER_CREATE_USER_EVENT)
+	    && (pmCmd != TRACER_DESTROY_USER_EVENT)
+	    && (pmCmd != TRACER_TRACE_USER_EVENT)
+	    && (pmCmd != TRACER_SET_EVENT_MASK)
+	    && (pmCmd != TRACER_GET_EVENT_MASK))
+		return -ENOSYS;
+
+	/* Depending on the command executed */
+	switch (pmCmd) {
+	/* Start the tracer */
+	case TRACER_START:
+		/* Check if the device has been properly set up */
+		if (((sUseSyscallEIPBounds == TRUE)
+		     && (sSyscallEIPDepthSet == TRUE))
+		    || ((sUseSyscallEIPBounds == TRUE)
+			&& ((sLowerEIPBoundSet != TRUE)
+			    || (sUpperEIPBoundSet != TRUE)))
+		    || ((sTracingPID == TRUE)
+			&& (sTracingPGRP == TRUE)))
+			return -EINVAL;
+
+		/* Set the kernel-side trace configuration */
+		if (trace_set_config(trace,
+				     sSyscallEIPDepthSet,
+				     sUseSyscallEIPBounds,
+				     sSyscallEIPDepth,
+				     sLowerEIPBound,
+				     sUpperEIPBound) < 0)
+			return -EINVAL;
+
+		/* Always log the start event and the buffer start event */
+		ltt_set_bit(TRACE_EV_BUFFER_START, &sTracedEvents);
+		ltt_set_bit(TRACE_EV_BUFFER_START, &sLogEventDetailsMask);
+		ltt_set_bit(TRACE_EV_START, &sTracedEvents);
+		ltt_set_bit(TRACE_EV_START, &sLogEventDetailsMask);
+		ltt_set_bit(TRACE_EV_CHANGE_MASK, &sTracedEvents);
+		ltt_set_bit(TRACE_EV_CHANGE_MASK, &sLogEventDetailsMask);
+
+		/* Get the time of start */
+		do_gettimeofday(&sBufferStartTime);
+
+		/* Set the event description */
+		lStartBufferEvent.ID = sBufferID;
+		lStartBufferEvent.Time = sBufferStartTime;
+
+		/* Set the event description */
+		lStartEvent.MagicNumber = TRACER_MAGIC_NUMBER;
+		lStartEvent.ArchType = TRACE_ARCH_TYPE;
+		lStartEvent.ArchVariant = TRACE_ARCH_VARIANT;
+		lStartEvent.SystemType = TRACE_SYS_TYPE_VANILLA_LINUX;
+		lStartEvent.MajorVersion = TRACER_VERSION_MAJOR;
+		lStartEvent.MinorVersion = TRACER_VERSION_MINOR;
+		lStartEvent.BufferSize = sBufSize;
+		lStartEvent.EventMask = sTracedEvents;
+		lStartEvent.DetailsMask = sLogEventDetailsMask;
+		lStartEvent.LogCPUID = sLogCPUID;
+
+		/* Trace the buffer start event */
+		trace(TRACE_EV_BUFFER_START, &lStartBufferEvent);
+
+		/* Trace the start event */
+		trace(TRACE_EV_START, &lStartEvent);
+
+		/* Start tapping into Linux's syscall flow */
+		syscall_entry_trace_active = ltt_test_bit(TRACE_EV_SYSCALL_ENTRY, &sTracedEvents);
+		syscall_exit_trace_active  = ltt_test_bit(TRACE_EV_SYSCALL_EXIT, &sTracedEvents);
+
+		/* We can start tracing */
+		sTracerStarted = TRUE;
+
+		/* Reregister custom trace events created earlier */
+		trace_reregister_custom_events();
+		break;
+
+	/* Stop the tracer */
+	case TRACER_STOP:
+		/* Stop tracing */
+		sTracerStarted = FALSE;
+
+		/* Stop interrupting the normal flow of system calls */
+		syscall_entry_trace_active = 0;
+		syscall_exit_trace_active  = 0;
+
+		/* Acquire the lock to avoid SMP case of where another CPU is writing a trace
+		   while buffer is being switched */
+		spin_lock_irqsave(&sSpinLock, lFlags);
+
+		/* Switch the buffers to ensure that the end of the buffer mark is set (time isn't important) */
+		tracer_switch_buffers(sBufferStartTime);
+
+		/* Release lock */
+		spin_unlock_irqrestore(&sSpinLock, lFlags);
+		break;
+
+	/* Set the tracer to the default configuration */
+	case TRACER_CONFIG_DEFAULT:
+		tracer_set_default_config();
+		break;
+
+	/* Set the memory buffers the daemon wants us to use */
+	case TRACER_CONFIG_MEMORY_BUFFERS:
+		/* Is the given size "reasonnable" */
+		if (pmArg < TRACER_MIN_BUF_SIZE)
+			return -EINVAL;
+
+		/* Set the buffer's size */
+		return tracer_set_buffer_size(pmArg);
+		break;
+
+	/* Trace the given events */
+	case TRACER_CONFIG_EVENTS:
+		if (copy_from_user(&sTracedEvents, (void *) pmArg, sizeof(sTracedEvents)))
+			return -EFAULT;
+		break;
+
+	/* Record the details of the event, or not */
+	case TRACER_CONFIG_DETAILS:
+		if (copy_from_user(&sLogEventDetailsMask, (void *) pmArg, sizeof(sLogEventDetailsMask)))
+			return -EFAULT;
+		break;
+
+	/* Record the CPUID associated with the event */
+	case TRACER_CONFIG_CPUID:
+		sLogCPUID = TRUE;
+		break;
+
+	/* Trace only one process */
+	case TRACER_CONFIG_PID:
+		sTracingPID = TRUE;
+		sTracedPID = pmArg;
+		break;
+
+	/* Trace only the given process group */
+	case TRACER_CONFIG_PGRP:
+		sTracingPGRP = TRUE;
+		sTracedPGRP = pmArg;
+		break;
+
+	/* Trace the processes of a given group of users */
+	case TRACER_CONFIG_GID:
+		sTracingGID = TRUE;
+		sTracedGID = pmArg;
+		break;
+
+	/* Trace the processes of a given user */
+	case TRACER_CONFIG_UID:
+		sTracingUID = TRUE;
+		sTracedUID = pmArg;
+		break;
+
+	/* Set the call depth a which the EIP should be fetched on syscall */
+	case TRACER_CONFIG_SYSCALL_EIP_DEPTH:
+		sSyscallEIPDepthSet = TRUE;
+		sSyscallEIPDepth = pmArg;
+		break;
+
+	/* Set the lowerbound address from which EIP is recorded on syscall */
+	case TRACER_CONFIG_SYSCALL_EIP_LOWER:
+		/* We are using bounds for fetching the EIP where syscall was made */
+		sUseSyscallEIPBounds = TRUE;
+
+		/* Set the lower bound */
+		sLowerEIPBound = (void *) pmArg;
+
+		/* The lower bound has been set */
+		sLowerEIPBoundSet = TRUE;
+		break;
+
+	/* Set the upperbound address from which EIP is recorded on syscall */
+	case TRACER_CONFIG_SYSCALL_EIP_UPPER:
+		/* We are using bounds for fetching the EIP where syscall was made */
+		sUseSyscallEIPBounds = TRUE;
+
+		/* Set the upper bound */
+		sUpperEIPBound = (void *) pmArg;
+
+		/* The upper bound has been set */
+		sUpperEIPBoundSet = TRUE;
+		break;
+
+	/* The daemon has comitted the last trace */
+	case TRACER_DATA_COMITTED:
+#if 0
+		printk("Tracer: Data has been comitted \n");
+#endif
+
+		/* Safely set the signal sent flag to FALSE */
+		spin_lock_irqsave(&sSpinLock, lFlags);
+		sSignalSent = FALSE;
+		spin_unlock_irqrestore(&sSpinLock, lFlags);
+		break;
+
+	/* Get the number of events lost */
+	case TRACER_GET_EVENTS_LOST:
+		return sEventsLost;
+		break;
+
+	/* Create a user event */
+	case TRACER_CREATE_USER_EVENT:
+		/* Copy the information from user space */
+		if (copy_from_user(&lNewUserEvent, (void *) pmArg, sizeof(lNewUserEvent)))
+			return -EFAULT;
+
+		/* Create the event */
+		lNewUserEventID = trace_create_owned_event(lNewUserEvent.type,
+							   lNewUserEvent.desc,
+							   lNewUserEvent.format_type,
+							   lNewUserEvent.form,
+							   current->pid);
+
+		/* Has the operation succeded */
+		if (lNewUserEventID >= 0) {
+			/* Set the event ID */
+			lNewUserEvent.id = lNewUserEventID;
+
+			/* Copy the event information back to user space */
+			if (copy_to_user((void *) pmArg, &lNewUserEvent, sizeof(lNewUserEvent))) {
+				/* Since we were unable to tell the user about the event, destroy it */
+				trace_destroy_event(lNewUserEventID);
+				return -EFAULT;
+			}
+		} else
+			/* Forward trace_create_event()'s error code */
+			return lNewUserEventID;
+		break;
+
+	/* Destroy a user event */
+	case TRACER_DESTROY_USER_EVENT:
+		/* Pass on the user's request */
+		trace_destroy_event((int) pmArg);
+		break;
+
+	/* Trace a user event */
+	case TRACER_TRACE_USER_EVENT:
+		/* Copy the information from user space */
+		if (copy_from_user(&lUserEvent, (void *) pmArg, sizeof(lUserEvent)))
+			return -EFAULT;
+
+		/* Copy the user event data */
+		if (copy_from_user(sUserEventData, lUserEvent.data, lUserEvent.data_size))
+			return -EFAULT;
+
+		/* Log the raw event */
+		lRetValue = trace_raw_event(lUserEvent.id,
+					    lUserEvent.data_size,
+					    sUserEventData);
+
+		/* Has the operation failed */
+		if (lRetValue < 0)
+			/* Forward trace_create_event()'s error code */
+			return lRetValue;
+		break;
+
+	/* Set event mask */
+	case TRACER_SET_EVENT_MASK:
+		/* Copy the information from user space */
+		if (copy_from_user(&(lTraceMask.mask), (void *) pmArg, sizeof(lTraceMask.mask)))
+			return -EFAULT;
+
+		/* Trace the event */
+		lRetValue = trace(TRACE_EV_CHANGE_MASK, &lTraceMask);
+
+		/* Change the event mask. (This has to be done second or else may loose the
+		   information if the user decides to stop logging "change mask" events) */
+		memcpy(&sTracedEvents, &(lTraceMask.mask), sizeof(lTraceMask.mask));
+		syscall_entry_trace_active = ltt_test_bit(TRACE_EV_SYSCALL_ENTRY, &sTracedEvents);
+		syscall_exit_trace_active  = ltt_test_bit(TRACE_EV_SYSCALL_EXIT, &sTracedEvents);
+
+		/* Always trace the buffer start, the trace start and the change mask */
+		ltt_set_bit(TRACE_EV_BUFFER_START, &sTracedEvents);
+		ltt_set_bit(TRACE_EV_START, &sTracedEvents);
+		ltt_set_bit(TRACE_EV_CHANGE_MASK, &sTracedEvents);
+
+		/* Forward trace()'s error code */
+		return lRetValue;
+		break;
+
+	/* Get event mask */
+	case TRACER_GET_EVENT_MASK:
+		/* Copy the information to user space */
+		if (copy_to_user((void *) pmArg, &sTracedEvents, sizeof(sTracedEvents)))
+			return -EFAULT;
+		break;
+
+	/* Unknow command */
+	default:
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+
+/**
+ *	tracer_mmap: - "Mmap" file op
+ *	@pmInode: the inode associated with the device
+ *	@pmFile: file structure given to the acting process
+ *	@pmVmArea: Virtual memory area description structure
+ *
+ *	Returns:
+ *	0 if ok
+ *	-EAGAIN, when remap failed
+ *	-EACCESS, permission denied
+ */
+int tracer_mmap(struct file *pmFile,
+		struct vm_area_struct *pmVmArea)
+{
+	int lRetValue;		/* Function's return value */
+
+	/* Only the trace daemon is allowed access to mmap */
+	if (current != sDaemonTaskStruct)
+		return -EACCES;
+
+	/* Remap trace buffer into the process's memory space */
+	lRetValue = tracer_mmap_region(pmVmArea,
+				       (char *) pmVmArea->vm_start,
+				       sTracBuf,
+				  pmVmArea->vm_end - pmVmArea->vm_start);
+
+#if 0
+	printk("Tracer: Trace buffer virtual address                  => 0x%08X \n", (u32) sTracBuf);
+	printk("Tracer: Trace buffer physical address                 => 0x%08X \n", (u32) virt_to_phys(sTracBuf));
+	printk("Tracer: Trace buffer virtual address in daemon space  => 0x%08X \n", (u32) pmVmArea->vm_start);
+	printk("Tracer: Trace buffer physical address in daemon space => 0x%08X \n", (u32) virt_to_phys((void *) pmVmArea->vm_start));
+#endif
+
+	return lRetValue;
+}
+
+/**
+ *	tracer_open(): - "Open" file op
+ *	@pmInode: the inode associated with the device
+ *	@pmFile: file structure given to the acting process
+ *
+ *	Returns:
+ *	0, everything went OK
+ *	-ENODEV, no such device.
+ *	-EBUSY, daemon channel (minor number 0) already in use.
+ */
+int tracer_open(struct inode *pmInode,
+		struct file *pmFile)
+{
+	int lDevMinor = minor(pmInode->i_rdev) & 0x0f;	/* Device minor number */
+
+	/* Only minor number 0 and 1 are used */
+	if ((lDevMinor > 0) && (lDevMinor != 1))
+		return -ENODEV;
+
+	/* If the device has already been opened */
+	if (sOpenCount) {
+		/* Is there another process trying to open the daemon's channel (minor number 0) */
+		if (lDevMinor == 0)
+			return -EBUSY;
+		else
+			/* Only increment use, this is just another user process trying to log user events */
+			goto IncrementUse;
+	}
+	/* Fetch the task structure of the process that opened the device */
+	sDaemonTaskStruct = current;
+
+	/* Reset the default configuration since this is the daemon and he will complete the setup */
+	tracer_set_default_config();
+
+#if 0
+	/* DEBUG */
+	printk("<1>Process %d opened the tracing device \n", sDaemonTaskStruct->pid);
+#endif
+
+IncrementUse:
+	/* Lock the device */
+	sOpenCount++;
+
+#ifdef MODULE
+	/* Increment module usage */
+	MOD_INC_USE_COUNT;
+#endif
+
+	return 0;
+}
+
+/**
+ *	tracer_release: - "Release" file op
+ *	@pmInode: the inode associated with the device
+ *	@pmFile: file structure given to the acting process
+ *
+ *	Returns: 
+ *	0, everything went OK
+ *
+ *	Note:
+ *	It is assumed that if the tracing daemon dies, exits or simply stops
+ *	existing, the kernel or "someone" will call tracer_release. Otherwise,
+ *      we're in trouble ...
+ */
+int tracer_release(struct inode *pmInode,
+		   struct file *pmFile)
+{
+	int lDevMinor = minor(pmInode->i_rdev) & 0x0f;	/* Device minor number */
+
+	/* Is this a simple user process exiting? */
+	if (lDevMinor != 0)
+		goto DecrementUse;
+
+	/* Did we loose any events */
+	if (sEventsLost > 0)
+		printk(KERN_ALERT "Tracer: Lost %d events \n", sEventsLost);
+
+	/* Reset the daemon PID */
+	sDaemonTaskStruct = NULL;
+
+	/* Free the current buffers, if any */
+	if (sTracBuf != NULL)
+		rvfree(sTracBuf, sAllocSize);
+
+	/* Reset the read and write buffers */
+	sTracBuf = NULL;
+	sWritBuf = NULL;
+	sReadBuf = NULL;
+	sWritBufEnd = NULL;
+	sReadBufEnd = NULL;
+	sWritPos = NULL;
+	sReadLimit = NULL;
+	sWritLimit = NULL;
+
+	/* Reset the tracer's configuration */
+	tracer_set_default_config();
+	sTracerStarted = FALSE;
+
+	/* Reset number of bytes recorded and number of events lost */
+	sBufReadComplete = 0;
+	sSizeReadIncomplete = 0;
+	sEventsLost = 0;
+
+	/* Reset signal sent */
+	sSignalSent = FALSE;
+
+DecrementUse:
+	/* Unlock the device */
+	sOpenCount--;
+
+#ifdef MODULE
+	/* Decrement module usage */
+	MOD_DEC_USE_COUNT;
+#endif
+
+	return 0;
+}
+
+/**
+ *	tracer_fsync: - "Fsync" file op
+ *	@pmFile: file structure given to the acting process
+ *	@pmDEntry: dentry associated with file
+ *
+ *	Returns:
+ *	0, everything went OK
+ *	-EACCESS, permission denied
+ *
+ *	Note:
+ *	We need to look the modifications of the values because they are read
+ *	and written by trace().
+ */
+int tracer_fsync(struct file *pmFile,
+		 struct dentry *pmDEntry,
+		 int pmDataSync)
+{
+	unsigned long int lFlags;
+
+	/* Only the trace daemon is allowed access to fsync */
+	if (current != sDaemonTaskStruct)
+		return -EACCES;
+
+	/* Lock the kernel */
+	spin_lock_irqsave(&sSpinLock, lFlags);
+
+	/* Reset the write positions */
+	sWritPos = sWritBuf;
+
+	/* Reset read limit */
+	sReadLimit = sReadBuf;
+
+	/* Reset bytes recorded */
+	sBufReadComplete = 0;
+	sSizeReadIncomplete = 0;
+	sEventsLost = 0;
+
+	/* Reset signal sent */
+	sSignalSent = FALSE;
+
+	/* Unlock the kernel */
+	spin_unlock_irqrestore(&sSpinLock, lFlags);
+
+	return 0;
+}
+
+/**
+ *	tracer_set_buffer_size: - Sets the size of the buffers.
+ *	@pmSize: Size of buffers
+ *
+ *	Returns:
+ *	0, Size setting went OK
+ *	-ENOMEM, unable to get a hold of memory for tracer
+ */
+int tracer_set_buffer_size(int pmSize)
+{
+	int lSizeAlloc;
+
+	/* Set size to allocate (= pmSize * 2) and fix it's size to be on a page boundary */
+	lSizeAlloc = FIX_SIZE(pmSize << 1);
+
+	/* Free the current buffers, if any */
+	if (sTracBuf != NULL)
+		rvfree(sTracBuf, sAllocSize);
+
+	/* Allocate space for the tracing buffers */
+	if ((sTracBuf = (char *) rvmalloc(lSizeAlloc)) == NULL)
+		return -ENOMEM;
+
+	/* Remember the size set */
+	sBufSize = pmSize;
+	sAllocSize = lSizeAlloc;
+
+	/* Set the read and write buffers */
+	sWritBuf = sTracBuf;
+	sReadBuf = sTracBuf + sBufSize;
+
+	/* Set end of buffers */
+	sWritBufEnd = sWritBuf + sBufSize;
+	sReadBufEnd = sReadBuf + sBufSize;
+
+	/* Set write position */
+	sWritPos = sWritBuf;
+
+	/* Set read limit */
+	sReadLimit = sReadBuf;
+
+	/* Set write limit */
+	sWritLimit = sWritBufEnd - TRACER_LAST_EVENT_SIZE;
+
+	return 0;
+}
+
+/**
+ *	tracer_set_default_config: - Sets the tracer in its default config
+ *
+ *	Returns:
+ *	0, everything went OK
+ *	-ENOMEM, unable to get a hold of memory for tracer
+ */
+int tracer_set_default_config(void)
+{
+	int i;
+	int lError = 0;
+
+	/* Initialize the event mask */
+	sTracedEvents = 0;
+
+	/* Initialize the event mask with all existing events with their details */
+	for (i = 0; i <= TRACE_EV_MAX; i++) {
+		ltt_set_bit(i, &sTracedEvents);
+		ltt_set_bit(i, &sLogEventDetailsMask);
+	}
+
+	/* Do not interfere with Linux's syscall flow until we actually start tracing */
+	syscall_entry_trace_active = 0;
+	syscall_exit_trace_active  = 0;
+
+	/* Forget about the CPUID */
+	sLogCPUID = FALSE;
+
+	/* We aren't tracing any PID or GID in particular */
+	sTracingPID = FALSE;
+	sTracingPGRP = FALSE;
+	sTracingGID = FALSE;
+	sTracingUID = FALSE;
+
+	/* We aren't looking for a particular call depth */
+	sSyscallEIPDepthSet = FALSE;
+
+	/* We aren't going to place bounds on syscall EIP fetching */
+	sUseSyscallEIPBounds = FALSE;
+	sLowerEIPBoundSet = FALSE;
+	sUpperEIPBoundSet = FALSE;
+
+	/* Set the kernel trace configuration to it's basics */
+	trace_set_config(trace,
+			 sSyscallEIPDepthSet,
+			 sUseSyscallEIPBounds,
+			 0,
+			 0,
+			 0);
+
+	return lError;
+}
+
+/**
+ *	tracer_init: - Tracer initialization function.
+ *
+ *	Returns:
+ *	0, everything went OK
+ *	-ENONMEM, incapable of allocating necessary memory
+ *	Forwarded error code otherwise
+ */
+int __init tracer_init(void)
+{
+	int lError = 0;
+
+	/* Initialize configuration */
+	if ((lError = tracer_set_default_config()) < 0)
+		return lError;
+
+	/* Initialize open count */
+	sOpenCount = 0;
+
+	/* Initialize tracer lock */
+	sTracLock = 0;
+
+	/* Initialize signal sent */
+	sSignalSent = FALSE;
+
+	/* Initialize bytes read and events lost */
+	sBufReadComplete = 0;
+	sSizeReadIncomplete = 0;
+	sEventsLost = 0;
+
+	/* Initialize buffer ID */
+	sBufferID = 0;
+
+	/* Initialize tracing daemon task structure */
+	sDaemonTaskStruct = NULL;
+
+	/* Allocate memory for large data components */
+	if ((sUserEventData = vmalloc(CUSTOM_EVENT_MAX_SIZE)) < 0)
+		return -ENOMEM;
+
+	/* Initialize spin lock */
+	sSpinLock = SPIN_LOCK_UNLOCKED;
+
+	/* Register the tracer as a char device */
+	sMajorNumber = register_chrdev(0, TRACER_NAME, &sTracerFileOps);
+
+	/* Register the tracer with the kernel */
+	if ((lError = register_tracer(trace)) < 0) {
+		/* Tell the user about the problem */
+		printk(KERN_ALERT "Tracer: Unable to register tracer with kernel, tracer disabled \n");
+
+		/* Make sure no one can open this device */
+		sOpenCount = 1;
+	} else
+		printk(KERN_INFO "Tracer: Initialization complete \n");
+
+	return lError;
+}
+
+/* Is this loaded as a module */
+#ifdef MODULE
+/**
+ *	cleanup_module: - Cleanup of the tracer.
+ *
+ *	No return values.
+ *
+ *	Note: The order of the unregesterings is important. First, rule out any
+ *	possibility of getting more trace data. Second, rule out any
+ *	possibility of being read by the tracing daemon. Last, free the tracing
+ *	buffer.
+ */
+void tracer_exit(void)
+{
+	/* Unregister the tracer from the kernel */
+	unregister_tracer(trace);
+
+	/* Unregister the tracer from being a char device */
+	unregister_chrdev(sMajorNumber, TRACER_NAME);
+
+	/* Free the current buffers, if any */
+	if (sTracBuf != NULL)
+		rvfree(sTracBuf, sAllocSize);
+
+	/* Paranoia */
+	sTracBuf = NULL;
+}
+module_exit(tracer_exit);
+#endif				/* #ifdef MODULE */
+
+module_init(tracer_init);
diff -urN linux-2.5.34/drivers/trace/tracer.h linux-2.5.34-ltt/drivers/trace/tracer.h
--- linux-2.5.34/drivers/trace/tracer.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.34-ltt/drivers/trace/tracer.h	Mon Sep  9 19:06:34 2002
@@ -0,0 +1,160 @@
+/*
+ * drivers/trace/tracer.h
+ *
+ * Copyright (C) 1999, 2000, 2001, 2002 Karim Yaghmour (karim@opersys.com)
+ * Portions contributed by T. Halloran: (C) Copyright 2002 IBM Poughkeepsie, IBM Corporation
+ *
+ * This contains the necessary definitions the system tracer
+ */
+
+#ifndef _TRACER_H
+#define _TRACER_H
+
+/* Logic values */
+#define FALSE 0
+#define TRUE  1
+
+/* Structure packing within the trace */
+#ifndef LTT_PACKED_STRUCT
+#if LTT_UNPACKED_STRUCTS
+#define LTT_PACKED_STRUCT
+#else				/* if LTT_UNPACKED_STRUCTS */
+#define LTT_PACKED_STRUCT __attribute__ ((packed));
+#endif				/* if LTT_UNPACKED_STRUCTS */
+#endif				/* if LTT_PACKED_STRUCT */
+
+/* Tracer properties */
+#define TRACER_NAME      "tracer"	/* Name of the device as seen in /proc/devices */
+
+/* Tracer buffer information */
+#define TRACER_DEFAULT_BUF_SIZE   50000		/* Default size of tracing buffer */
+#define TRACER_MIN_BUF_SIZE        1000		/* Minimum size of tracing buffer */
+#define TRACER_MAX_BUF_SIZE      500000		/* Maximum size of tracing buffer */
+
+/* Local definitions */
+typedef u32 trace_time_delta;	/* The type used to start the time delta between events */
+
+/* Number of bytes set aside for last event */
+#define TRACER_LAST_EVENT_SIZE   (sizeof(u8) + sizeof(u8) + sizeof(trace_time_delta) + sizeof(u32))
+
+/* System types */
+#define TRACE_SYS_TYPE_VANILLA_LINUX        1	/* Vanilla linux kernel  */
+
+/* The information logged when the tracing is started */
+#define TRACER_MAGIC_NUMBER     0x00D6B7ED	/* That day marks an important historical event ... */
+#define TRACER_VERSION_MAJOR    1	/* Major version number */
+#define TRACER_VERSION_MINOR   14	/* Minor version number */
+typedef struct _trace_start {
+	u32 MagicNumber;	/* Magic number to identify a trace */
+	u32 ArchType;		/* Type of architecture */
+	u32 ArchVariant;	/* Variant of the given type of architecture */
+	u32 SystemType;		/* Operating system type */
+	u8 MajorVersion;	/* Major version of trace */
+	u8 MinorVersion;	/* Minor version of trace */
+
+	u32 BufferSize;		/* Size of buffers */
+	trace_event_mask EventMask;	/* The event mask */
+	trace_event_mask DetailsMask;	/* Are the event details logged */
+	u8 LogCPUID;		/* Is the CPUID logged */
+} LTT_PACKED_STRUCT trace_start;
+
+/* Start and end of trace buffer information */
+typedef struct _trace_buffer_start {
+	struct timeval Time;	/* Time stamp of this buffer */
+	u32 ID;			/* Unique buffer ID */
+} LTT_PACKED_STRUCT trace_buffer_start;
+
+/* The configurations possible */
+#define TRACER_START                      TRACER_MAGIC_NUMBER + 0	/* Start tracing events using the current configuration */
+#define TRACER_STOP                       TRACER_MAGIC_NUMBER + 1	/* Stop tracing */
+#define TRACER_CONFIG_DEFAULT             TRACER_MAGIC_NUMBER + 2	/* Set the tracer to the default configuration */
+#define TRACER_CONFIG_MEMORY_BUFFERS      TRACER_MAGIC_NUMBER + 3	/* Set the memory buffers the daemon wants us to use */
+#define TRACER_CONFIG_EVENTS              TRACER_MAGIC_NUMBER + 4	/* Trace the given events */
+#define TRACER_CONFIG_DETAILS             TRACER_MAGIC_NUMBER + 5	/* Record the details of the event, or not */
+#define TRACER_CONFIG_CPUID               TRACER_MAGIC_NUMBER + 6	/* Record the CPUID associated with the event */
+#define TRACER_CONFIG_PID                 TRACER_MAGIC_NUMBER + 7	/* Trace only one process */
+#define TRACER_CONFIG_PGRP                TRACER_MAGIC_NUMBER + 8	/* Trace only the given process group */
+#define TRACER_CONFIG_GID                 TRACER_MAGIC_NUMBER + 9	/* Trace the processes of a given group of users */
+#define TRACER_CONFIG_UID                 TRACER_MAGIC_NUMBER + 10	/* Trace the processes of a given user */
+#define TRACER_CONFIG_SYSCALL_EIP_DEPTH   TRACER_MAGIC_NUMBER + 11	/* Set the call depth at which the EIP should be fetched on syscall */
+#define TRACER_CONFIG_SYSCALL_EIP_LOWER   TRACER_MAGIC_NUMBER + 12	/* Set the lowerbound address from which EIP is recorded on syscall */
+#define TRACER_CONFIG_SYSCALL_EIP_UPPER   TRACER_MAGIC_NUMBER + 13	/* Set the upperbound address from which EIP is recorded on syscall */
+#define TRACER_DATA_COMITTED              TRACER_MAGIC_NUMBER + 14	/* The daemon has comitted the last trace */
+#define TRACER_GET_EVENTS_LOST            TRACER_MAGIC_NUMBER + 15	/* Get the number of events lost */
+#define TRACER_CREATE_USER_EVENT          TRACER_MAGIC_NUMBER + 16	/* Create a user tracable event */
+#define TRACER_DESTROY_USER_EVENT         TRACER_MAGIC_NUMBER + 17	/* Destroy a user tracable event */
+#define TRACER_TRACE_USER_EVENT           TRACER_MAGIC_NUMBER + 18	/* Trace a user event */
+#define TRACER_SET_EVENT_MASK             TRACER_MAGIC_NUMBER + 19	/* Set the trace event mask */
+#define TRACER_GET_EVENT_MASK             TRACER_MAGIC_NUMBER + 20	/* Get the trace event mask */
+
+extern __inline__ int ltt_set_bit(int nr, void *addr)
+{
+	unsigned char *p = addr;
+	unsigned char mask = 1 << (nr & 7);
+	unsigned char old;
+
+	p += nr >> 3;
+	old = *p;
+	*p |= mask;
+
+	return ((old & mask) != 0);
+}
+
+extern __inline__ int ltt_clear_bit(int nr, void *addr)
+{
+	unsigned char *p = addr;
+	unsigned char mask = 1 << (nr & 7);
+	unsigned char old;
+
+	p += nr >> 3;
+	old = *p;
+	*p &= ~mask;
+
+	return ((old & mask) != 0);
+}
+
+extern __inline__ int ltt_test_bit(int nr, void *addr)
+{
+	unsigned char *p = addr;
+	unsigned char mask = 1 << (nr & 7);
+
+	p += nr >> 3;
+
+	return ((*p & mask) != 0);
+}
+
+/* Function prototypes */
+int trace
+ (u8,
+  void *);
+void tracer_switch_buffers
+ (struct timeval);
+int tracer_ioctl
+ (struct inode *,
+  struct file *,
+  unsigned int,
+  unsigned long);
+int tracer_mmap
+ (struct file *,
+  struct vm_area_struct *);
+int tracer_open
+ (struct inode *,
+  struct file *);
+int tracer_release
+ (struct inode *,
+  struct file *);
+int tracer_fsync
+ (struct file *,
+  struct dentry *,
+  int);
+#ifdef MODULE
+void tracer_exit
+ (void);
+#endif /* #ifdef MODULE */
+int tracer_set_buffer_size
+ (int);
+int tracer_set_default_config
+ (void);
+int tracer_init
+ (void);
+#endif				/* _TRACER_H */
