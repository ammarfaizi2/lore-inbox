Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272796AbSISW1T>; Thu, 19 Sep 2002 18:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273703AbSISW1T>; Thu, 19 Sep 2002 18:27:19 -0400
Received: from nameservices.net ([208.234.25.16]:34152 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S272796AbSISWYz>;
	Thu, 19 Sep 2002 18:24:55 -0400
Message-ID: <3D8A50A7.7019E183@opersys.com>
Date: Thu, 19 Sep 2002 18:33:11 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.36 2/9: Trace driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the LTT trace driver itself. The bulk of the lockless tracing
scheme is implemented here. The user can choose between the locking and
the lockless scheme by passing the appropriate parameter the daemon's
command line.

Here are the file modifications:
 drivers/Makefile          |    1
 drivers/trace/Config.help |   36
 drivers/trace/Config.in   |    4
 drivers/trace/Makefile    |   17
 drivers/trace/tracer.c    | 2340 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/trace/tracer.h    |  232 ++++
 6 files changed, 2630 insertions

diff -urpN linux-2.5.36/drivers/Makefile linux-2.5.36-ltt/drivers/Makefile
--- linux-2.5.36/drivers/Makefile	Tue Sep 17 20:59:12 2002
+++ linux-2.5.36-ltt/drivers/Makefile	Thu Sep 19 16:29:56 2002
@@ -41,5 +41,6 @@ obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BLUEZ)		+= bluetooth/
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_ISDN_BOOL)		+= isdn/
+obj-$(CONFIG_TRACE)		+= trace/
 
 include $(TOPDIR)/Rules.make
diff -urpN linux-2.5.36/drivers/trace/Config.help linux-2.5.36-ltt/drivers/trace/Config.help
--- linux-2.5.36/drivers/trace/Config.help	Wed Dec 31 19:00:00 1969
+++ linux-2.5.36-ltt/drivers/trace/Config.help	Thu Sep 19 16:29:56 2002
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
diff -urpN linux-2.5.36/drivers/trace/Config.in linux-2.5.36-ltt/drivers/trace/Config.in
--- linux-2.5.36/drivers/trace/Config.in	Wed Dec 31 19:00:00 1969
+++ linux-2.5.36-ltt/drivers/trace/Config.in	Thu Sep 19 16:29:56 2002
@@ -0,0 +1,4 @@
+mainmenu_option next_comment
+comment 'Kernel tracing'
+tristate 'Kernel events tracing support' CONFIG_TRACE
+endmenu
diff -urpN linux-2.5.36/drivers/trace/Makefile linux-2.5.36-ltt/drivers/trace/Makefile
--- linux-2.5.36/drivers/trace/Makefile	Wed Dec 31 19:00:00 1969
+++ linux-2.5.36-ltt/drivers/trace/Makefile	Thu Sep 19 16:29:56 2002
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
diff -urpN linux-2.5.36/drivers/trace/tracer.c linux-2.5.36-ltt/drivers/trace/tracer.c
--- linux-2.5.36/drivers/trace/tracer.c	Wed Dec 31 19:00:00 1969
+++ linux-2.5.36-ltt/drivers/trace/tracer.c	Thu Sep 19 16:38:48 2002
@@ -0,0 +1,2340 @@
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
+ *    16/02/02, Added Tom Zanussi's implementation of K42's lockless logging.
+ *              K42 tracing guru Robert Wisniewski participated in the
+ *              discussions surrounding this implementation. A big thanks to
+ *              the IBM folks.
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
+static int              sUseLocking;		/* Holds command from daemon */
+static u32              sBufnoBits;             /* Holds command from daemon */
+static u32              sBufOffsetBits;         /* Holds command from daemon */
+static int              sBuffersFull;           /* All-buffers-full boolean */
+static u32              sLastEventIndex;        /* For full-buffers state */ 
+static struct timeval   sLastEventTimeStamp;    /* For full-buffers state */ 
+
+/*  Time */
+static struct timeval sBufferStartTime;		/* The time at which the buffer was started */
+
+/*  Large data components allocated at load time */
+static char *sUserEventData = NULL;		/* The data associated with a user event */
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
+/* The global per-buffer control data structure, shared between the tracing
+   driver and the trace daemon via ioctl. */
+static struct buffer_control sBufferControl;
+
+/* Space reserved for TRACE_EV_BUFFER_START */
+static u32 sStartReserve = TRACER_FIRST_EVENT_SIZE; 
+
+/* Space reserved for TRACE_EV_BUFFER_END event + sizeof lost word, which 
+   though the sizeof lost word isn't necessarily contiguous with rest of 
+   event (it's always at the end of the buffer) is included here for code 
+   clarity. */
+static u32 sEndReserve = TRACER_LAST_EVENT_SIZE; 
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
+/*** Lockless scheme functions ***/
+
+/**
+ *	init_buffer_control: - Init buffer control struct for new tracing run.
+ *	@pmBC: 
+ *	@pmUseLockless:
+ *	@pmBufnoBits: 
+ *	@pmOffsetBits:
+ *
+ *	Sanity of param values should be checked by caller. i.e. bufno_bits and
+ *	offset_bits must reflect sane buffer sizes/numbers.
+ */
+static void init_buffer_control(struct buffer_control * pmBC,
+				int pmUseLockless,
+				u8 pmBufnoBits,
+				u8 pmOffsetBits)
+{
+	unsigned i;
+	
+	if((pmBC->using_lockless = pmUseLockless) == TRUE) {
+		pmBC->index = sStartReserve;
+		pmBC->bufno_bits = pmBufnoBits;
+		pmBC->n_buffers = TRACE_MAX_BUFFER_NUMBER(pmBufnoBits);
+		pmBC->offset_bits = pmOffsetBits;
+		pmBC->offset_mask = TRACE_BUFFER_OFFSET_MASK(pmOffsetBits);
+		pmBC->index_mask = (1UL << (pmBufnoBits + pmOffsetBits)) - 1;
+		
+		pmBC->buffers_produced = pmBC->buffers_consumed = 0;
+
+		/* When a new buffer is switched to, TRACE_BUFFER_SIZE is
+		   subtracted from its fill_count in order to initialize it
+		   to the empty state.  The reason it's done this way is
+		   because an intervening event may have already been written 
+		   to the buffer while we were in the process of switching and
+		   thus blindly initializing to 0 would erase that event.
+		   The first buffer is initialized to 0 and the others are 
+		   initialized to TRACE_BUFFER_SIZE because the very first 
+		   buffer we ever see won't be initialized in that way by 
+		   the switching code and since there's never been an event, 
+		   we know it should be 0 and that it must be explicitly 
+		   initialized that way before logging begins.  sStartReserve
+		   is is factored into the end-of-buffer processing, so isn't
+		   added to the fill counts here, except for the first. */
+		atomic_set(&pmBC->fill_count[0], (int)sStartReserve);
+		for(i = 1; i < TRACER_MAX_BUFFERS; i++)
+			atomic_set(&pmBC->fill_count[i], (int)TRACE_BUFFER_SIZE(pmOffsetBits));
+
+		/* All buffers are empty at this point */
+		sBuffersFull = FALSE;
+	}
+}
+	
+/* These inline atomic functions wrap the linux versions in order to 
+   implement the interface we want as well as to ensure memory barriers. */
+
+/**
+ *	compare_and_store_volatile: - Self-explicit
+ *	@ptr: 
+ *	@oval:
+ *	@nval:
+ *
+ *	If *ptr is still what we think it is, atomically assign nval to it and
+ *	return a boolean indicating TRUE if the new value was stored, FALSE
+ *	otherwise.
+ *
+ *	Pseudocode for this operation:
+ *  
+ *	if(*ptr == oval) {
+ *	   *ptr = nval;
+ *	   return TRUE;
+ *	} else {
+ *	   return FALSE;
+ *	}
+ *
+ *	We need barriers before and after because despite what the locking
+ *	guide states, all atomic operations in Linux apparently don't act
+ *	as memory barriers.
+ */
+inline int compare_and_store_volatile(volatile u32 *ptr, 
+				      u32 oval,
+				      u32 nval)
+{
+	u32 prev;
+
+	barrier();
+	prev = cmpxchg(ptr, oval, nval);
+	barrier();
+
+	return (prev == oval);
+}
+
+/**
+ *	atomic_set_volatile: - Atomically set the value in ptr to nval.
+ *	@ptr: 
+ *	@nval: 
+ *
+ *	Uses memory barriers to set ptr to nval.
+ */
+inline void atomic_set_volatile(atomic_t *ptr,
+				u32 nval)
+{
+	barrier();
+	atomic_set(ptr, (int)nval);
+	barrier();
+}
+
+/**
+ *	atomic_add_volatile: - Atomically add val to the value at ptr.
+ *	@ptr: 
+ *	@val: 
+ *
+ *	Uses memory barriers to add val to ptr.
+ */
+inline void atomic_add_volatile(atomic_t *ptr, u32 val)
+{
+	barrier();
+	atomic_add((int)val, ptr);
+	barrier();
+}
+
+/**
+ *	atomic_sub_volatile: - Atomically substract val from the value at ptr.
+ *	@ptr: 
+ *	@val: 
+ *
+ *	Uses memory barriers to substract val from ptr.
+ */
+inline void atomic_sub_volatile(atomic_t *ptr, s32 val)
+{
+	barrier();
+	atomic_sub((int)val, ptr);
+	barrier();
+}
+
+/**
+ *	trace_commit: - Atomically add len to fill_count.
+ *	@index: 
+ *	@len: 
+ *
+ *	Atomically add len to the fill_count of the buffer containing index.
+ */
+static inline void trace_commit(u32 index, u32 len)
+{
+	u32 bufno = TRACE_BUFFER_NUMBER_GET(index, sBufferControl.offset_bits);
+	atomic_add_volatile(&sBufferControl.fill_count[bufno], len);
+}
+
+/**
+ *	write_start_buffer_event: - Write start event to begining of buffer.
+ *	@pmIndex:
+ *	@pmTime:
+ *
+ *	Writes start event at the beginning of the buffer containing new_index.
+ */
+static inline void write_start_buffer_event(u32 pmIndex, struct timeval pmTime)
+{
+	trace_buffer_start lStartBufferEvent; /* Start of new buffer event */
+	u8 lEventID;			/* Event ID of last event */
+	uint16_t lDataSize;		/* Size of tracing data */
+	trace_time_delta lTimeDelta;	/* The time elapsed between now and the last event */
+	char* lWritPos;	        	/* Current position for writing */
+
+	/* Clear the offset bits of index to get the beginning of buffer */
+	lWritPos = sTracBuf + TRACE_BUFFER_OFFSET_CLEAR(pmIndex, 
+						sBufferControl.offset_mask);
+
+	/* Increment buffer ID */
+	sBufferID++;
+	
+	/* Write the start of buffer event */
+	lStartBufferEvent.ID = sBufferID;
+	lStartBufferEvent.Time = pmTime;
+
+	/* Write event type to tracing buffer */
+	lEventID = TRACE_EV_BUFFER_START;
+	tracer_write_to_buffer(lWritPos,
+			       &lEventID,
+			       sizeof(lEventID));
+
+	/* Write event time delta to tracing buffer */
+	lTimeDelta = 0;
+	tracer_write_to_buffer(lWritPos,
+			       &lTimeDelta,
+			       sizeof(lTimeDelta));
+
+	/* Write event structure */
+	tracer_write_to_buffer(lWritPos,
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
+	tracer_write_to_buffer(lWritPos,
+			       &lDataSize,
+			       sizeof(lDataSize));
+}
+
+/**
+ *	write_end_buffer_event: - Write end buffer event at index.
+ *	@pmIndex:
+ *	@pmTime:
+ */
+static inline void write_end_buffer_event(u32 pmIndex, struct timeval pmTime)
+{
+	u8 lEventID;			/* Event ID of last event */
+	u8 lCPUID;			/* CPUID of currently runing process */
+	trace_time_delta lTimeDelta;	/* The time elapsed between now and the last event */
+	char* lWritPos;	        	/* Current position for writing */
+
+	lWritPos = sTracBuf + pmIndex;
+
+	/* Write the CPUID to the tracing buffer, if required */
+	if (sLogCPUID == TRUE) {
+		lCPUID = smp_processor_id();
+		tracer_write_to_buffer(lWritPos,
+				       &lCPUID,
+				       sizeof(lCPUID));
+	}
+	/* Write event type to tracing buffer */
+	lEventID = TRACE_EV_BUFFER_END;
+	tracer_write_to_buffer(lWritPos,
+			       &lEventID,
+			       sizeof(lEventID));
+
+	/* Write event time delta to tracing buffer */
+	lTimeDelta = 0;
+	tracer_write_to_buffer(lWritPos,
+			       &lTimeDelta,
+			       sizeof(lTimeDelta));
+}
+
+/**
+ *	write_lost_size: - Write lost size to end of buffer containing index.
+ *	@pmIndex: 
+ *	@pmSizeLost: 
+ */
+static inline void write_lost_size(u32 pmIndex, u32 pmSizeLost)
+{
+	char* lWritBufEnd;		/* End of buffer */
+
+	/* Get end of buffer by clearing offset and adding buffer size */
+	lWritBufEnd = sTracBuf
+	  + TRACE_BUFFER_OFFSET_CLEAR(pmIndex, sBufferControl.offset_mask)
+	  + TRACE_BUFFER_SIZE(sBufferControl.offset_bits);
+
+	/* Write size lost at the end of the buffer */
+	*((u32 *) (lWritBufEnd - sizeof(pmSizeLost))) = pmSizeLost;
+}
+
+/**
+ *	finalize_buffer: - 
+ *	@pmEndIndex: 
+ *	@pmSizeLost: 
+ *	@pmTimestampe:
+ *
+ *	This function must be called from within a lock, because it increments
+ *	buffers_produced.
+ */
+static inline void finalize_buffer(u32 pmEndIndex, u32 pmSizeLost, struct timeval *pmTimestamp)
+{
+	/* Write end buffer event as last event in old buffer. */
+	write_end_buffer_event(pmEndIndex, *pmTimestamp);
+
+	/* In any buffer switch, we need to write out the lost size,
+	   which can be 0. */
+	write_lost_size(pmEndIndex, pmSizeLost);
+
+	/* Add the size lost and end event size to fill_count so that 
+	   the old buffer won't be seen as incomplete. */
+	trace_commit(pmEndIndex, pmSizeLost);
+
+	/* Every finalized buffer means a produced buffer */
+	sBufferControl.buffers_produced++;
+}
+
+/**
+ *	finalize_lockless_trace: - 
+ *
+ *	Called when tracing is stopped, to finish processing last buffer. Note
+ *	that there will always be space for the last event in the current
+ *	buffer.
+ */
+static inline void finalize_lockless_trace(void)
+{
+	u32 lEventsEnd;                 /* Index of end of last event */
+	u32 lSizeLost;                  /* Bytes after end of last event */
+	unsigned long int lFlags;       /* CPU flags for lock */
+
+	/* Find index of end of last event */
+	lEventsEnd = TRACE_BUFFER_OFFSET_GET(sBufferControl.index, sBufferControl.offset_mask);
+
+	/* Size lost in buffer is the unused space after end of last event
+	   and end of buffer. */
+	lSizeLost = TRACE_BUFFER_SIZE(sBufferControl.offset_bits) - lEventsEnd;
+
+	/* Lock the kernel */
+	spin_lock_irqsave(&sSpinLock, lFlags);
+
+	/* Write end event etc. and increment buffers_produced.  The  
+	   time used here is what the locking version uses as well. */
+	finalize_buffer(sBufferControl.index & sBufferControl.index_mask, lSizeLost, &sBufferStartTime);
+
+	/* Unlock the kernel */
+	spin_unlock_irqrestore(&sSpinLock, lFlags);
+}
+
+/**
+ *	discard_check: -  Determine whether the event should be discarded.
+ *	@pmOldIndex: 
+ *	@pmLen:
+ *	@pmTimestamp: 
+ *
+ *	The return value contains the result flags.
+ *	Return value is an ORed combination of:
+ *
+ *	LTT_EVENT_DISCARD_NONE - event should not be discarded
+ *	LTT_BUFFER_SWITCH - buffer switch occurred
+ *	LTT_EVENT_DISCARD - event should be discarded (all buffers are full)
+ *	LTT_EVENT_TOO_LONG - event won't fit into even an empty buffer
+ */
+static inline int discard_check(u32 pmOldIndex,
+				u32 pmLen, 
+				struct timeval *pmTimestamp)
+{
+	u32 lBuffersReady;
+	u32 lOffsetMask = sBufferControl.offset_mask;
+	u8 lOffsetBits = sBufferControl.offset_bits;
+	u32 lIndexMask = sBufferControl.index_mask;
+	u32 lSizeLost;
+	unsigned long int lFlags; /* CPU flags for lock */
+
+	/* Check whether the event is larger than a buffer */ 
+	if(pmLen >= TRACE_BUFFER_SIZE(sBufferControl.offset_bits))
+		return LTT_EVENT_DISCARD | LTT_EVENT_TOO_LONG;
+
+	/* Lock the kernel */
+	spin_lock_irqsave(&sSpinLock, lFlags);
+
+	/* We're already overrun, nothing left to do */  
+	if(sBuffersFull == TRUE) {
+		/* Unlock the kernel */
+		spin_unlock_irqrestore(&sSpinLock, lFlags);
+
+		return LTT_EVENT_DISCARD;
+	}
+	
+	lBuffersReady = sBufferControl.buffers_produced - sBufferControl.buffers_consumed;
+
+	/* If this happens, we've been pushed to the edge of the last 
+	   available buffer which means we need to finalize it and increment 
+	   buffers_produced.  However, we don't want to allow 
+	   sBufferControl.index to be actually pushed to full or beyond, 
+	   otherwise we'd just be wrapping around and allowing subsequent
+	   events to overwrite good buffers.  It is true that there may not
+	   be enough space for this event, but there could be space for 
+	   subsequent smaller event(s).  It doesn't matter if they write 
+	   themselves, because here we say that anything after the old_index 
+	   passed in to this function is lost, even if other events have or 
+	   will reserve space in this last buffer.  Nor can any other event
+	   reserve space in buffers following this one, until at least one
+	   buffer is consumed by the daemon. */
+	if(lBuffersReady == sBufferControl.n_buffers - 1) {
+		/* We set this flag so we only do this once per overrun */
+		sBuffersFull = TRUE;
+
+		/* Get the time of the event */
+		do_gettimeofday(pmTimestamp);
+
+		/* Size lost is everything after old_index */
+		lSizeLost = TRACE_BUFFER_SIZE(lOffsetBits)
+		  - TRACE_BUFFER_OFFSET_GET(pmOldIndex, lOffsetMask);
+
+		/* Write end event and lost size.  This increases buffer_count
+		   by the lost size, which is important later when we add the
+		   deferred size. */
+		finalize_buffer(pmOldIndex & lIndexMask, lSizeLost, pmTimestamp);
+
+		/* We need to add the lost size to old index, but we can't
+		   do it now, or we'd roll index over and allow new events,
+		   so we defer it until a buffer is free.  Note however that
+		   buffer_count does get incremented by lost size, which is
+		   important later when start logging again. */
+		sLastEventIndex = pmOldIndex;
+		sLastEventTimeStamp = *pmTimestamp;
+
+		/* Unlock the kernel */
+		spin_unlock_irqrestore(&sSpinLock, lFlags);
+
+		/* We lose this event */
+		return LTT_BUFFER_SWITCH | LTT_EVENT_DISCARD;
+	}
+	/* Unlock the kernel */
+	spin_unlock_irqrestore(&sSpinLock, lFlags);	
+
+	/* Nothing untoward happened */
+	return LTT_EVENT_DISCARD_NONE;
+}
+
+/**
+ *	trace_reserve_slow: - The slow reserve path in the lockless scheme.
+ *	@pmOldIndex: 
+ *	@pmLen:
+ *	@pmIndex: 
+ *	@pmTimestamp: 
+ *
+ *	Called by trace_reserve if the length of the event being logged would
+ *	most likely cause a 'buffer switch'.  The value of the variable pointed
+ *	to by 'index' will contain the index actually reserved by this
+ *	function. The boolean return value indicates whether there actually was
+ *	a buffer switch (not inevitable in certain cases).
+ *
+ *	Return value is an ORed combination of:
+ *	LTT_BUFFER_SWITCH_NONE - no buffer switch occurred 
+ *	LTT_EVENT_DISCARD_NONE - event should not be discarded
+ *	LTT_BUFFER_SWITCH - buffer switch occurred
+ *	LTT_EVENT_DISCARD - event should be discarded (all buffers are full)
+ *	LTT_EVENT_TOO_LONG - event won't fit into even an empty buffer
+ */
+static inline int trace_reserve_slow(u32 pmOldIndex, /* needed for overruns */
+				     u32 pmLen,
+				     u32 *pmIndex,
+				     struct timeval *pmTimestamp)
+{
+	u32 lNewIndex, lOffset, lNewBufno;
+	unsigned long int lFlags; /* CPU flags for lock */
+	u32 lOffsetMask = sBufferControl.offset_mask;
+	u8 lOffsetBits = sBufferControl.offset_bits;
+	u32 lIndexMask = sBufferControl.index_mask;
+	u32 lSizeLost = sEndReserve; /* size lost always includes end event */
+	int lDiscardEvent;
+	int lBufferSwitched = LTT_BUFFER_SWITCH_NONE;
+
+	/* We don't get here unless the event might cause a buffer switch */
+
+	/* First check whether conditions exist do discard the event */
+	lDiscardEvent = discard_check(pmOldIndex, pmLen, pmTimestamp);
+	if(lDiscardEvent != LTT_EVENT_DISCARD_NONE)
+		return lDiscardEvent;
+
+	/* If we're here, we still have free buffers to reserve from */
+
+	/* Do this until we reserve a spot for the event */
+	do {
+		/* Yeah, we're re-using a param variable, is that bad form? */ 
+		pmOldIndex = sBufferControl.index;
+
+		/* We're here because the event + ending reserve space would
+		   overflow or exactly fill old buffer.  Calculate new index
+		   again. */
+		lNewIndex = pmOldIndex + pmLen;
+
+		/* We only care about the offset part of the new index */
+		lOffset = TRACE_BUFFER_OFFSET_GET(lNewIndex + sEndReserve, lOffsetMask);
+
+		/* If we would actually overflow and not exactly fill the old 
+		   buffer, we reserve the first slot (after adding a buffer 
+		   start event) in the new one. */
+		if((lOffset < pmLen) && (lOffset > 0)) {
+
+			/* This is an overflow, not an exact fit.  The 
+			   reserved index is just after the space reserved for
+			   the start event in the new buffer. */
+			*pmIndex = TRACE_BUFFER_OFFSET_CLEAR(lNewIndex + sEndReserve, lOffsetMask)
+			  + sStartReserve;
+
+			/* Now the next free space is at the reserved index 
+			   plus the length of this event. */
+			lNewIndex = *pmIndex + pmLen;
+		} else if (lOffset < pmLen) {
+			/* We'll exactly fill the old buffer, so our reserved
+			   index is still in the old buffer and our new index
+			   is in the new one + sStartReserve */
+			*pmIndex = pmOldIndex;
+			lNewIndex = TRACE_BUFFER_OFFSET_CLEAR(lNewIndex + sEndReserve, lOffsetMask)
+			  + sStartReserve;
+		} else
+			/* another event has actually pushed us into a new 
+			   buffer since we were called. */ 
+			*pmIndex = pmOldIndex;
+					
+		/* Get the time of the event */
+		do_gettimeofday(pmTimestamp);
+	} while (!compare_and_store_volatile(&sBufferControl.index, 
+					     pmOldIndex, lNewIndex));
+
+	/* Once we're successful in saving a new_index as the authoritative
+	   new global buffer control index, finish the buffer switch 
+	   processing. */
+
+	/* Mask off the high bits outside of our reserved index */
+	*pmIndex &= lIndexMask;
+
+	/* At this point, our indices are set in stone, so we can safely
+	   write our start and end events and lost count to our buffers.
+	   The first test here could fail if between the time reserve_slow
+	   was called and we got a reserved slot, we slept and someone else
+	   did the buffer switch already. */
+	if(lOffset < pmLen) { /* Event caused a buffer switch. */
+		if(lOffset > 0) /* We didn't exactly fill the old buffer */
+			/* Set the size lost value in the old buffer.  That
+			   value is len+sEndReserve-offset-sEndReserve,
+			   i.e. sEndReserve cancels itself out. */
+			lSizeLost += pmLen - lOffset;
+		else /* We exactly filled the old buffer */
+			/* Since we exactly filled the old buffer, the index 
+			   we write the end event to is after the space 
+			   reserved for this event. */
+			pmOldIndex += pmLen;
+
+		/* Lock the kernel */
+		spin_lock_irqsave(&sSpinLock, lFlags);
+
+		/* Write end event etc. and increment buffers_produced. */
+		finalize_buffer(pmOldIndex & lIndexMask, lSizeLost, pmTimestamp);
+
+		/* If we're here, we had a normal buffer switch and need to 
+		   update the start buffer time before writing the event.  
+		   The start buffer time is the same as the event time for the 
+		   event reserved, and lTimeDelta of 0 but that also appears 
+		   to be the case in the locking version as well. */
+		sBufferStartTime = *pmTimestamp;
+
+		/* Unlock the kernel */
+		spin_unlock_irqrestore(&sSpinLock, lFlags);
+
+		/* new_index is always valid here, since it's set correctly 
+		   if offset < len + sEndReserve, and we don't get here
+		   unless that's true.  The issue would be that if we didn't
+		   actually switch buffers, new_index would be too large by
+		   sEndReserve bytes. */
+		write_start_buffer_event(lNewIndex & lIndexMask, *pmTimestamp);
+
+		/* We initialize the new buffer by subtracting 
+		   TRACE_BUFFER_SIZE rather than directly initializing to 
+		   sStartReserve in case events have been already been added 
+		   to the new buffer under us.  We subtract space for the start
+		   buffer event from buffer size to leave room for the start
+		   buffer event we just wrote. */
+		lNewBufno = TRACE_BUFFER_NUMBER_GET(lNewIndex & lIndexMask, lOffsetBits);
+		atomic_sub_volatile(&sBufferControl.fill_count[lNewBufno],
+				    TRACE_BUFFER_SIZE(lOffsetBits) - sStartReserve);
+
+		/* We need to check whether fill_count is less than the 
+		   sStartReserve.  If this test is true, it means that 
+		   subtracting the buffer size underflowed fill_count i.e. 
+		   fill_count represents an incomplete buffer.  Any any case, 
+		   we're completely fubared and don't have any choice but to 
+		   start the new buffer out fresh. */
+		if(atomic_read(&sBufferControl.fill_count[lNewBufno]) < sStartReserve)
+			atomic_set_volatile(&sBufferControl.fill_count[lNewBufno], sStartReserve);
+		   
+		/* If we're here, there must have been a buffer switch */
+		lBufferSwitched = LTT_BUFFER_SWITCH;
+	}
+	
+	return lBufferSwitched;
+}
+
+/**
+ *	trace_reserve: -  Reserve a space in a buffer for len bytes.
+ *	@pmLen: 
+ *	@pmIndex: 
+ *	@pmTimestamp:
+ *
+ *	The value of the variable pointed to by 'index' will contain the index
+ *	actually reserved by this function.
+ *
+ *	Return value is an ORed combination of:
+ *	LTT_BUFFER_SWITCH_NONE - no buffer switch occurred
+ *	LTT_EVENT_DISCARD_NONE - event should not be discarded
+ *	LTT_BUFFER_SWITCH - buffer switch occurred
+ *	LTT_EVENT_DISCARD - event should be discarded (all buffers are full)
+ *	LTT_EVENT_TOO_LONG - event won't fit into even an empty buffer
+ */
+static inline int trace_reserve(u32 pmLen, 
+				u32 *pmIndex, 
+				struct timeval *pmTimestamp)
+{
+	u32 lOldIndex, lNewIndex, lOffset;
+	u32 lOffsetMask = sBufferControl.offset_mask;
+
+	/* Do this until we reserve a spot for the event */
+	do {
+		lOldIndex = sBufferControl.index;
+
+		/* If adding len + sEndReserve to the old index doesn't put us
+		   into a new buffer, this is what the new index would be. */
+		lNewIndex = lOldIndex + pmLen;
+		lOffset = TRACE_BUFFER_OFFSET_GET(lNewIndex + sEndReserve, lOffsetMask);
+
+		/* If adding the length reserved for the end buffer event and
+		   lost count to the new index would put us into a new buffer,
+		   we need to do a buffer switch.  If in between now and the 
+		   buffer switch another event that does fit comes in, no 
+		   problem because we check again in the slow version.  In 
+		   either case, there will always be room for the end event 
+		   in the old buffer.  The trick in this test is that adding 
+		   a length that would carry into the non-offset bits of the 
+		   index results in the offset portion being smaller than the 
+		   length that was added. */
+		if(lOffset < pmLen)
+			/* We would roll over into a new buffer, need to do 
+			   buffer switch processing. */
+			return trace_reserve_slow(lOldIndex, pmLen, pmIndex, pmTimestamp);
+
+		/* Get the time of the event */
+		do_gettimeofday(pmTimestamp);
+	} while (!compare_and_store_volatile(&sBufferControl.index, 
+					     lOldIndex, lNewIndex));
+
+	/* Once we're successful in saving a new_index as the authoritative
+	   new global buffer control index, we can return old_index, the 
+	   successfully reserved index. */
+
+        /* Return the reserved index value */
+	*pmIndex = lOldIndex & sBufferControl.index_mask;
+
+	return LTT_BUFFER_SWITCH_NONE; /* No buffer switch occurred */
+}
+
+/**
+ *	lockless_write_event: - 
+ *	@pmEventID: 
+ *	@pmEventStruct: 
+ *	@pmDataSize: 
+ *	@pmCPUID: 
+ *	@pmVarDataBeg: 
+ *	@pmVarDataLen: 
+ *
+ *	Reserve space for an event, write the event and signal the daemon if it
+ *	caused a buffer switch.
+ */
+int lockless_write_event(u8 pmEventID, 
+			 void *pmEventStruct,	
+			 uint16_t pmDataSize,
+			 u8 pmCPUID,
+			 void *pmVarDataBeg,
+			 int pmVarDataLen)
+{
+	u32 lReservedIndex;
+	struct timeval lTime;
+	trace_time_delta lTimeDelta;	/* The time elapsed between now and the last event */
+	struct siginfo lSigInfo;	/* Signal information */
+	int lReserveRC;
+	char* lWritPos;	        	/* Current position for writing */
+	int lRC = 0;
+
+	/* Reserve space for the event.  If the space reserved is in a new
+	   buffer, note that fact. */
+	lReserveRC = trace_reserve((u32)pmDataSize, 
+				   &lReservedIndex, &lTime);
+
+	/* Exact lost event count isn't important to anyone, so this is OK. */
+	if(lReserveRC & LTT_EVENT_DISCARD)
+		sEventsLost++;
+
+	/* We don't write the event, but we still need to signal */
+	if((lReserveRC & LTT_BUFFER_SWITCH) && 
+	   (lReserveRC & LTT_EVENT_DISCARD)) {
+		lRC = -ENOMEM;
+		goto send_buffer_switch_signal;
+	}
+	
+	/* no buffer space left, discard event. */
+	if((lReserveRC & LTT_EVENT_DISCARD) || 
+	   (lReserveRC & LTT_EVENT_TOO_LONG))
+		/* return value for trace() */
+		return -ENOMEM;
+
+	/* The position we write to in the trace memory area is simply the
+	   beginning of trace memory plus the index we just reserved. */
+	lWritPos = sTracBuf + lReservedIndex;
+	/* Compute the time delta between this event and the time at which 
+	   this buffer was started */
+	lTimeDelta = (lTime.tv_sec - sBufferStartTime.tv_sec) * 1000000
+		+ (lTime.tv_usec - sBufferStartTime.tv_usec);
+
+	/* Write the CPUID to the tracing buffer, if required */
+	if ((sLogCPUID == TRUE) && (pmEventID != TRACE_EV_START) && (pmEventID != TRACE_EV_BUFFER_START))
+		tracer_write_to_buffer(lWritPos,
+				       &pmCPUID,
+				       sizeof(pmCPUID));
+
+	/* Write event type to tracing buffer */
+	tracer_write_to_buffer(lWritPos,
+			       &pmEventID,
+			       sizeof(pmEventID));
+
+	/* Write event time delta to tracing buffer */
+	tracer_write_to_buffer(lWritPos,
+			       &lTimeDelta,
+			       sizeof(lTimeDelta));
+
+	/* Do we log event details */
+	if (ltt_test_bit(pmEventID, &sLogEventDetailsMask)) {
+		/* Write event structure */
+		tracer_write_to_buffer(lWritPos,
+				       pmEventStruct,
+				       sEventStructSize[pmEventID]);
+
+		/* Write string if any */
+		if (pmVarDataLen)
+			tracer_write_to_buffer(lWritPos,
+					       pmVarDataBeg,
+					       pmVarDataLen);
+	}
+	/* Write the length of the event description */
+	tracer_write_to_buffer(lWritPos,
+			       &pmDataSize,
+			       sizeof(pmDataSize));
+
+	/* We've written the event - update the fill_count for the buffer. */ 
+	
+	trace_commit(lReservedIndex, (u32)pmDataSize);
+
+send_buffer_switch_signal:
+
+	/* Signal the daemon if we switched buffers */
+	if(lReserveRC & LTT_BUFFER_SWITCH) {
+		/* Setup signal information */
+		lSigInfo.si_signo = SIGIO;
+		lSigInfo.si_errno = 0;
+		lSigInfo.si_code = SI_KERNEL;
+
+#if 0
+		/* DEBUG */
+		printk("<1> Sending SIGIO to %d \n", sDaemonTaskStruct->pid);
+#endif
+		/* Signal the tracing daemon */
+		send_sig_info(SIGIO, &lSigInfo, sDaemonTaskStruct);
+	} 
+
+	return lRC;
+}
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
+
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
+
+	/* Do we record the CPUID */
+	if ((sLogCPUID == TRUE) && (pmEventID != TRACE_EV_START) && (pmEventID != TRACE_EV_BUFFER_START)) {
+		/* Remember the CPUID */
+		lCPUID = smp_processor_id();
+
+		/* Update the size of the data entry */
+		lDataSize += sizeof(lCPUID);
+	}
+
+/* Lock-free event-writing isn't available without cmpxchg */
+#ifdef __HAVE_ARCH_CMPXCHG
+	/* If we're using the lockless scheme, we preempt the default path 
+	   here - nothing after this point in this function will be executed. 
+	   Note that even if we do have cmpxchg, we still want to have a 
+	   choice between the lock-free and locking schemes at run-time, thus 
+	   the using_lockless check.  This used to be implemented as a kernel 
+	   hook, and will be again when/if kernel hooks are accepted into the 
+	   kernel. */
+	if(sBufferControl.using_lockless)
+		return lockless_write_event(pmEventID, 
+					    pmEventStruct,	
+					    lDataSize,
+					    lCPUID,
+					    lVarDataBeg,
+					    lVarDataLen);
+#endif
+
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
+ *	continue_trace: - Continue a stopped trace.
+ *
+ *	Continue a trace that's been temporarily stopped because all buffers
+ *	were full.
+ */
+static inline void continue_trace(void)
+{
+	int lDiscardSize;
+	u32 lLastEventBufno;
+	u32 lLastBufferLostSize;
+	u32 lLastEventOffset;
+	u32 lNewIndex;
+			
+	/* A buffer's been consumed, and as we've been waiting around at the 
+	   end of the last one produced, the one after that must now be free */
+	int lFreedBufno = sBufferControl.buffers_produced % sBufferControl.n_buffers;
+
+	/* Start the new buffer out at the beginning */
+	atomic_set_volatile(&sBufferControl.fill_count[lFreedBufno], sStartReserve);
+
+	/* In the all-buffers-full case, sBufferControl.index is frozen at the 
+	   position of the first event that would have caused a buffer switch.
+	   However, the fill_count for that buffer is not frozen and reflects 
+	   not only the lost size calculated at that point, but also any 
+	   smaller events that managed to write themselves at the end of the 
+	   last buffer (because there's technically still space at the end, 
+	   though it and all those contained events will be erased here).  
+	   Here we try to salvage if possible that last buffer, but to do 
+	   that, we need to subtract those pesky smaller events that managed 
+	   to get in.  If after all that, another small event manages to 
+	   sneak in in the time it takes us to do this, well, we concede and 
+	   the daemon will toss that buffer.  It's not the end of the world 
+	   if that happens, since that buffer actually marked the start of a 
+	   bunch of lost events which continues until a buffer is freed. */
+
+	/* Get the bufno and offset of the buffer containing the last event 
+	   logged before we had to stop for a buffer-full condition. */
+	lLastEventOffset = TRACE_BUFFER_OFFSET_GET(sLastEventIndex, sBufferControl.offset_mask);
+	lLastEventBufno = TRACE_BUFFER_NUMBER_GET(sLastEventIndex, sBufferControl.offset_bits);
+
+	/* We also need to know the lost size we wrote to that buffer when we 
+	   stopped */
+	lLastBufferLostSize = TRACE_BUFFER_SIZE(sBufferControl.offset_bits) - lLastEventOffset;
+
+	/* Since the time we stopped, some smaller events probably reserved 
+	   space and wrote themselves in, the sizes of which would have been 
+	   reflected in the fill_count.  The total size of these events is 
+	   calculated here.  */  
+	lDiscardSize = atomic_read(&sBufferControl.fill_count[lLastEventBufno])
+	  - lLastEventOffset
+	  - lLastBufferLostSize;
+
+	/* If there were events written after we stopped, subtract those from 
+	   the fill_count.  If that doesn't fix things, the buffer either is 
+	   really incomplete, or another event snuck in, and we'll just stop 
+	   now and say we did what we could for it. */
+	if(lDiscardSize > 0)
+		atomic_sub_volatile(&sBufferControl.fill_count[lLastEventBufno], lDiscardSize);
+
+	/* Since our end buffer event probably got trounced, rewrite it in old
+	   buffer. */
+	write_end_buffer_event(sLastEventIndex & sBufferControl.index_mask, sLastEventTimeStamp);
+
+	/* We also need to update the buffer start time and write the start 
+	   event for the next buffer, since we couldn't do it until now */
+	do_gettimeofday(&sBufferStartTime);
+
+	/* The current buffer control index is hanging around near the end of 
+	   the last buffer.  So we add the buffer size and clear the offset to
+	   get to the beginning of the newly freed buffer. */
+	lNewIndex = sBufferControl.index + TRACE_BUFFER_SIZE(sBufferControl.offset_bits);
+	lNewIndex = TRACE_BUFFER_OFFSET_CLEAR(lNewIndex, sBufferControl.offset_mask) + sStartReserve;
+	write_start_buffer_event(lNewIndex & sBufferControl.index_mask, sBufferStartTime);
+
+	/* Fixing up sBufferControl.index is simpler.  Since a buffer has been
+	   consumed, there's now at least one buffer free, and we can continue.
+	   We start off the next buffer in a fresh state.  Since nothing else 
+	   can be meaningfully updating the buffer control index, we can safely
+	   do that here.  'Meaningfully' means that there may be cases of 
+	   smaller events managing to update the index in the last buffer but 
+	   they're essentially erased by the lost size of that buffer when 
+	   sBuffersFull was set. We need to restart the index at the beginning
+	   of the next available buffer before turning off sBuffersFull, and 
+	   avoid an erroneous buffer switch.  */ 
+	sBufferControl.index = lNewIndex;
+
+	/* Now we can continue reserving events */
+	sBuffersFull = FALSE;
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
+	/* Get device's minor number */
+	lDevMinor = minor(pmInode->i_rdev) & 0x0f;
+
+	/* If the tracer is started, the daemon can't modify the configuration */
+	if ((lDevMinor == 0)
+	    && (sTracerStarted == TRUE)
+	    && (pmCmd != TRACER_STOP)
+	    && (pmCmd != TRACER_DATA_COMITTED)
+	    && (pmCmd != TRACER_GET_BUFFER_CONTROL))
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
+		/* Initialize buffer control regardless of scheme in use */
+		init_buffer_control(&sBufferControl,
+				    !sUseLocking,    /* using_lockless */
+				    sBufnoBits,      /* bufno_bits, 2**n */
+				    sBufOffsetBits); /* offset_bits, 2**n */
+
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
+		/* Trace the buffer start event using the appropriate method depending on the locking scheme */
+		if(sBufferControl.using_lockless == TRUE)
+			write_start_buffer_event(sBufferControl.index & sBufferControl.index_mask,
+						 sBufferStartTime);
+		else
+			trace(TRACE_EV_BUFFER_START, &lStartBufferEvent);
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
+ 		/* We don't log new events, but old lockless ones can finish */
+		sTracerStarted = FALSE;
+
+		/* Stop interrupting the normal flow of system calls */
+		syscall_entry_trace_active = 0;
+		syscall_exit_trace_active  = 0;
+
+ 		/* Make sure the last buffer touched is finalized */
+ 		if(sBufferControl.using_lockless) {
+ 			/* Write end buffer event as last event in old buf. */
+ 			finalize_lockless_trace();
+ 			break;
+ 		} /* Else locking scheme */
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
+		/* Is the given size "reasonable" */
+		if (sUseLocking == TRUE) {
+			if (pmArg < TRACER_MIN_BUF_SIZE)
+				return -EINVAL;
+		} else {
+			if ((pmArg < TRACER_LOCKLESS_MIN_BUF_SIZE) || 
+			    (pmArg > TRACER_LOCKLESS_MAX_BUF_SIZE))
+				return -EINVAL;
+		}
+
+		/* Set the buffer's size */
+		return tracer_set_buffer_size(pmArg);
+		break;
+
+	/* Set the number of memory buffers the daemon wants us to use */
+	case TRACER_CONFIG_N_MEMORY_BUFFERS:
+		/* Is the given size "reasonable" */
+		if ((sUseLocking == TRUE) || (pmArg < TRACER_MIN_BUFFERS) || 
+		    (pmArg > TRACER_MAX_BUFFERS))
+			return -EINVAL;
+
+		/* Set the number of buffers */
+		return tracer_set_n_buffers(pmArg);
+		break;
+
+	/* Set locking scheme the daemon wants us to use */
+	case TRACER_CONFIG_USE_LOCKING:
+		/* Set the locking scheme in a global for later */
+		sUseLocking = pmArg;
+#ifndef __HAVE_ARCH_CMPXCHG
+		if(sUseLocking == FALSE) /* Trying to use lock-free scheme */
+                        /* Lock-free scheme not supported on this platform */
+			return -EINVAL; 
+#endif
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
+		/* DEBUG */
+		printk("Tracer: Data has been committed \n");
+#endif
+
+		/* The lockless version doesn't use sSignalSent.  pmArg is the 
+		   number of buffers the daemon has told us it just consumed.
+		   Add that to the global count. */
+		if(sBufferControl.using_lockless) {
+			/* Lock the kernel */
+			spin_lock_irqsave(&sSpinLock, lFlags);
+
+			/* We consumed some buffers, note it. */
+			sBufferControl.buffers_consumed += (u32)pmArg;
+
+			/* If we were full, we no longer are */
+			if(sBuffersFull && ((u32)pmArg > 0))
+				continue_trace();
+
+			/* Unlock the kernel */
+			spin_unlock_irqrestore(&sSpinLock, lFlags);
+			break;
+		} /* Else locking version below */
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
+	/* Get buffer control data */
+	case TRACER_GET_BUFFER_CONTROL:
+		/* We can't copy_to_user() with a lock held (accessing user 
+		   memory may cause a page fault),  so buffers_produced may
+		   actually be larger than what the daemon sees when this
+		   snapshot is taken.  This isn't a problem because the
+		   daemon will get a chance to read the new buffer the next
+		   time it's signaled. */ 
+		/* Copy the buffer control information to user space */
+		if(copy_to_user((void *) pmArg, &sBufferControl, sizeof(sBufferControl)))
+			return -EFAULT;
+		break;
+
+	/* Unknown command */
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
+ *	-EBUSY, there are still event writes in progress so the buffer can't
+ *	be released.
+ *
+ *	Note:
+ *	It is assumed that if the tracing daemon dies, exits or simply stops
+ *	existing, the kernel or "someone" will call tracer_release. Otherwise,
+ *      we're in trouble ...
+ */
+int tracer_release(struct inode *pmInode,
+		   struct file *pmFile)
+{
+	int lCount;
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
+	/* Free the current buffers, if any, but only if they're not still
+	   in use */
+	if (sTracBuf != NULL) {
+		lCount = trace_get_pending_write_count();
+		if(lCount == 0)
+			rvfree(sTracBuf, sAllocSize);
+		else {
+			printk(KERN_ERR "Tracer: Couldn't release tracer - %d event writes pending \n",
+			       lCount);
+			return -EBUSY;
+		}
+	}
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
+	sUseLocking = TRUE;
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
+ *
+ *	sBufnoBits must have already been set before this function is called.
+ */
+int tracer_set_buffer_size(int pmSize)
+{
+	int lSizeAlloc;
+	int lNBuffers = TRACE_MAX_BUFFER_NUMBER(sBufnoBits);
+
+	if(sUseLocking == TRUE)
+		/* Set size to allocate (= pmSize * 2) and fix it's size to be on a page boundary */
+		lSizeAlloc = FIX_SIZE(pmSize << 1);
+	else {
+		/* Calculate power-of-2 buffer size */
+		if(hweight32(pmSize) != 1)
+			/* Invalid if # set bits != 1 */
+			return -EINVAL;
+			
+		/* Find position of one and only set bit */
+		sBufOffsetBits = ffs(pmSize) - 1;
+
+		/* Calculate total size of buffers */
+		lSizeAlloc = pmSize * lNBuffers;
+
+		/* Sanity check */ 
+		if(lSizeAlloc > TRACER_LOCKLESS_MAX_TOTAL_BUF_SIZE) 
+			return -EINVAL;
+	}
+
+	/* Free the current buffers, if any, but only if they're not still in use */
+	if (sTracBuf != NULL) {
+		if(trace_get_pending_write_count() == 0)
+			rvfree(sTracBuf, sAllocSize);
+		else
+			return -EBUSY;
+	}
+
+	/* Allocate space for the tracing buffers */
+	if ((sTracBuf = (char *) rvmalloc(lSizeAlloc)) == NULL)
+		return -ENOMEM;
+
+#if 0 /* DEBUG - init all of buffer with easy-to-spot default values */
+	{
+		int i;
+		for(i=0; i<lSizeAlloc; i+=4)
+			*((u32 *)(sTracBuf+i)) = 0xcafebabe;
+	}
+#endif
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
+ *	tracer_set_n_buffers: - Sets the number of buffers.
+ *	@pmNBuffers: number of buffers.
+ *
+ *	Sets the number of buffers containing the trace data, valid only for
+ *	lockless scheme, must be a power of 2.
+ *
+ *	Returns:
+ *	0, Size setting went OK
+ *	-EINVAL, not a power of 2
+ */
+int tracer_set_n_buffers(int pmNBuffers)
+{
+	if(hweight32(pmNBuffers) != 1) /* Invalid if # set bits in word != 1 */
+		return -EINVAL;
+		
+	/* Find position of one and only set bit */
+	sBufnoBits = ffs(pmNBuffers) - 1;
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
+	/* By default, use locking scheme */
+	sUseLocking = TRUE;
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
+ *	buffer, but only if it's not still in use - it's better to lose the
+ *	memory than crash the system.
+ */
+void tracer_exit(void)
+{
+	int lCount;
+
+	/* Unregister the tracer from the kernel */
+	unregister_tracer(trace);
+
+	/* Unregister the tracer from being a char device */
+	unregister_chrdev(sMajorNumber, TRACER_NAME);
+
+	/* Free the current buffers, if any, but only if they're not still n use */
+	if (sTracBuf != NULL) {
+		lCount = trace_get_pending_write_count();
+		if(lCount == 0)
+			rvfree(sTracBuf, sAllocSize);
+		else
+			printk(KERN_ERR "Tracer: Couldn't exit tracer - %d event writes pending \n",
+			       lCount);		
+	}
+
+	/* Paranoia */
+	if(trace_get_pending_write_count() == 0)
+		sTracBuf = NULL;
+}
+module_exit(tracer_exit);
+#endif				/* #ifdef MODULE */
+
+module_init(tracer_init);
diff -urpN linux-2.5.36/drivers/trace/tracer.h linux-2.5.36-ltt/drivers/trace/tracer.h
--- linux-2.5.36/drivers/trace/tracer.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.36-ltt/drivers/trace/tracer.h	Thu Sep 19 16:29:56 2002
@@ -0,0 +1,232 @@
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
+#define TRACER_MIN_BUFFERS            2		/* Minimum number of tracing buffers */
+#define TRACER_MAX_BUFFERS          256		/* Maximum number of tracing buffers */
+
+/* Local definitions */
+typedef u32 trace_time_delta;	/* The type used to start the time delta between events */
+
+/* Number of bytes reserved for first event */
+#define TRACER_FIRST_EVENT_SIZE   (sizeof(u8) + sizeof(trace_time_delta) + sizeof(trace_buffer_start) + sizeof(uint16_t))
+
+/* Number of bytes reserved for last event, including lost size word */
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
+#define TRACER_GET_BUFFER_CONTROL         TRACER_MAGIC_NUMBER + 21	/* Get the buffer control data for the lockless schem*/
+#define TRACER_CONFIG_N_MEMORY_BUFFERS    TRACER_MAGIC_NUMBER + 22	/* Set the number of memory buffers the daemon wants us to use */
+#define TRACER_CONFIG_USE_LOCKING         TRACER_MAGIC_NUMBER + 23      /* Set the locking scheme to use */
+
+/* For the lockless scheme:
+
+   A trace index is composed of two parts, a buffer number and a buffer 
+   offset.  The actual number of buffers allocated is a run-time decision, 
+   although it must be a power of two for efficient computation.  We define 
+   a maximum number of bits for the buffer number, because the fill_count 
+   array in buffer_control must have a fixed size.  offset_bits must be at 
+   least as large as the maximum event size+start/end buffer event size+
+   lost size word (since a buffer must be able to hold an event of maximum 
+   size).  Making offset_bits larger reduces fragmentation.  Making it 
+   smaller increases trace responsiveness. */
+
+/* We need at least enough room for the max custom event, and we also need
+   room for the start and end event.  We also need it to be a power of 2. */
+#define TRACER_LOCKLESS_MIN_BUF_SIZE CUSTOM_EVENT_MAX_SIZE + 8192 /* 16K */
+/* Because we use atomic_t as the type for fill_counts, which has only 24
+   usable bits, we have 2**24 = 16M max for each buffer. */
+#define TRACER_LOCKLESS_MAX_BUF_SIZE 0x1000000 /* 16M */
+/* Since we multiply n buffers by the buffer size, this provides a sanity
+   check, much less than the 256*16M possible. */
+#define TRACER_LOCKLESS_MAX_TOTAL_BUF_SIZE 0x8000000 /* 128M */
+
+#define TRACE_MAX_BUFFER_NUMBER(bufno_bits) (1UL << (bufno_bits))
+#define TRACE_BUFFER_SIZE(offset_bits) (1UL << (offset_bits))
+#define TRACE_BUFFER_OFFSET_MASK(offset_bits) (TRACE_BUFFER_SIZE(offset_bits) - 1)
+
+#define TRACE_BUFFER_NUMBER_GET(index, offset_bits) ((index) >> (offset_bits))
+#define TRACE_BUFFER_OFFSET_GET(index, mask) ((index) & (mask))
+#define TRACE_BUFFER_OFFSET_CLEAR(index, mask) ((index) & ~(mask))
+
+/* Flags returned by trace_reserve/trace_reserve_slow */
+#define LTT_BUFFER_SWITCH_NONE 0x00
+#define LTT_EVENT_DISCARD_NONE 0x00
+#define LTT_BUFFER_SWITCH      0x01
+#define LTT_EVENT_DISCARD      0x02
+#define LTT_EVENT_TOO_LONG     0x04
+
+/* Structure used for communicating buffer info between tracer and daemon
+   for lock-free tracing.  This is a per-buffer (CPU, etc.) data structure. */ 
+struct buffer_control
+{
+	int using_lockless;
+
+	u32 index;
+	u8 bufno_bits;
+	u32 n_buffers; /* cached value */
+	u8 offset_bits;
+	u32 offset_mask; /* cached value */
+	u32 index_mask; /* cached value */
+
+	u32 buffers_produced;
+	u32 buffers_consumed;
+	/* atomic_t has only 24 usable bits, limiting us to 16M buffers */
+	atomic_t fill_count[TRACER_MAX_BUFFERS];
+};
+
+/* If cmpxchg isn't defined for the architecture, we don't want to 
+   generate a link error - the locking scheme will still be available. */  
+#ifndef __HAVE_ARCH_CMPXCHG
+#define cmpxchg(p,o,n) 0
+#endif
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
+int tracer_set_n_buffers
+ (int);
+int tracer_set_default_config
+ (void);
+int tracer_init
+ (void);
+#endif				/* _TRACER_H */
