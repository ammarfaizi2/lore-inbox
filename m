Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286160AbRLJEFR>; Sun, 9 Dec 2001 23:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286161AbRLJEFI>; Sun, 9 Dec 2001 23:05:08 -0500
Received: from relay04.valueweb.net ([216.219.253.238]:30728 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S286160AbRLJEEu>; Sun, 9 Dec 2001 23:04:50 -0500
Message-ID: <3C14360A.EC8FD564@opersys.com>
Date: Sun, 09 Dec 2001 23:11:54 -0500
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16-TRACE i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] LTT-0.9.5pre4: User-space events and run-time trace mask 
 modification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

Version 0.9.5pre4 of the Linux Trace Toolkit is out. It now provides
the capability to log user-space events and to modify the trace mask
at run-time. A new library called libusertrace has been created which
interacts with the trace device using ioctl() calls. In order to
accommodate user-space events, a new device is being used, /dev/tracerU,
which has a minor number of 1. This device can be opened as many
times and by as many processes as necessary, while the /dev/tracer
node used by the trace daemon can only be opened once (understandably).
Running the "createdev.sh" script will create both entries appropriately.

Here is the API provided:
int trace_attach(void);
* Has to be called prior to any other user trace function in order
to attach to the trace device.

int trace_detach(void);
* Called once the user application is done with tracing.

int trace_create_event
       (char*         /* String describing event type */,
        char*         /* String to format standard event description */,
        int           /* Type of formatting used to log event data */,
        char*         /* Data specific to format */);
* The function used to create user events. This function works exactly
as its kernel counterpart.

int trace_destroy_event
       (int           /* The event ID given by trace_create_event() */);
* Function used to delete an event. Again, identical to kernel counterpart.

int trace_user_event
       (int           /* The event ID given by trace_create_event() */,
        int           /* The size of the raw data */,
        void*         /* Pointer to the raw event data */);
* The function used to actually trace the user event.

int trace_set_event_mask
       (trace_event_mask   /* The event mask to be set */);
* Sets the event trace mask as given by the caller.

int trace_get_event_mask
       (trace_event_mask*  /* Pointer to variable where to set event mask retrieved */);
* Provides the trace mask to the caller.

int trace_enable_event_trace
       (int          /* Event ID who's tracing is to be enabled */);
* Enables the tracing of a given event type. This function eventually
calls on trace_set_event_mask() internally.

int trace_disable_event_trace
       (int          /* Event ID who's tracing is to be disabled */);
* Disables the tracing of a given event type. This function eventually
calls on trace_set_event_mask() internally.

int trace_is_event_traced
       (int          /* Event ID to be checked for tracing */);
* Return 1 if the event is being traced.

A more complete description of each function can be found in
LibUserTrace/UserTrace.c.

Examples of applications using this API can be found in the "Examples"
directory within the LTT package. Examples/UserEvents contains an
example of 2 applications tracing custom events and Examples/UserMaskChange
contains an application that changes the trace mask during runtime.
Whenever a mask change occurs, this gets logged in the trace and the
event library sets the trace mask as the cumulative bitwise AND of the
consecutive masks. Hence, when the visualization tool starts, it knows
immediately whether the trace contains sufficient information to draw
the trace.

In order to have access to the API, the applications use the Include/UserTrace.h
and, if they need to know the event IDs, Include/LinuxEvents.h. The
linking of the applications is done with the "-lusertrace" flag in
order to tell the linker to dynamically link the libusertrace.so file.
After compilling the content of the "LibUserTrace" directory, and
the "LibLTT" directory as well, you will need to used "ldconfig" in order
to update the library database.

I've tested 0.9.5pre4 both on the i386 and the PPC and everything works
fine.

LTT 0.9.5pre4 can be found here:
ftp://ftp.opersys.com/pub/LTT/TraceToolkit-0.9.5pre4.tgz

LTT's home page is here:
http://www.opersys.com/LTT/

RTAI support is still broken in 0.9.5pre4 but will be fixed in 0.9.5 final
which is due out within a month or two. Meanwhile, check the "ExtraPatches"
directory of LTT's ftp site for an update to add support for RTAI 24.1.6a
with linux 2.4.9 to LTT 0.9.4.

Best regards,

Karim

===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
