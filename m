Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317760AbSGKEoB>; Thu, 11 Jul 2002 00:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317761AbSGKEoA>; Thu, 11 Jul 2002 00:44:00 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:43272 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S317760AbSGKEny>; Thu, 11 Jul 2002 00:43:54 -0400
Message-ID: <3D2D0DE0.F9D75703@opersys.com>
Date: Thu, 11 Jul 2002 00:47:28 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Richard J Moore <richardj_moore@uk.ibm.com>,
       John Levon <movement@marcelothewonderpenguin.com>,
       Andrew Morton <akpm@zip.com.au>, bob <bob@watson.ibm.com>,
       linux-kernel@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>,
       mjbligh@linux.ibm.com, John Levon <moz@compsoc.man.ac.uk>,
       Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Enhanced profiling support (was Re: vm lock contention reduction)
References: <OFF41DACAC.FEED90BA-ON80256BF2.004DC147@portsmouth.uk.ibm.com> <3D2C9972.BB3DA772@opersys.com> <20020710214157.GD1342@dualathlon.random>
Content-Type: multipart/mixed;
 boundary="------------4725E3C6E0FD8A48C0D137BE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4725E3C6E0FD8A48C0D137BE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Andrea Arcangeli wrote:
> btw, on the topic, with our semaphores there's no way to handle priority
> inversion with SCHED_RR tasks, if there's more than one task that runs
> in RT priority we may fall into starvation of RT tasks too the same way.
> 
> No starvation can happen of course if all tasks in the systems belongs
> to the same scheduler policy (nice levels can have effects but they're
> not indefinite delays).
> 
> The fix Ingo used for SCHED_IDLE is to have a special call to the
> scheduler while returning to userspace, so in the only place where we
> know the kernel isn't holding any lock. But while it's going to only
> generate some minor unexpected cpu load with SCHED_IDLE, generalizing
> that hack to make all tasks scheduling inside the kernel running with RT
> priority isn't going to provide a nice/fair behaviour (some task infact could
> run way too much if it's very system-hungry, in particular with
> -preempt, which could again generate starvation of userspace, even if
> not anymore because of kernel locks). Maybe I'm overlooking something
> simple but I guess it's not going to be easy to fix it, for the
> semaphores it isn't too bad, they could learn how to raise priority of a
> special holder when needed, but for any semaphore-by-hand (for example
> spinlock based) it would require some major auditing.

I wasn't aware of this particular problem, but I certainly can see LTT
as being helpful in trying to understand the actual interactions. The
custom event creation API is rather simple to use if you would like
to instrument some of the semaphore code (the Sys V IPC code is already
instrumented at a basic level):
trace_create_event()
trace_create_owned_event()
trace_destroy_event()
trace_std_formatted_event()
trace_raw_event()

Here's the complete description:
int trace_create_event(char*            pm_event_type,
		       char*            pm_event_desc,
		       int              pm_format_type,
		       char*            pm_format_data)
	pm_event_type is a short string describing the type of event.
	pm_event_desc is required if you are using
	trace_std_formatted_event(), more on this below.
	pm_format_type and pm_format_data are required if you are
	using trace_raw_event(). The function returns a unique
	custom event ID.

int trace_create_owned_event(char*            pm_event_type,
			     char*            pm_event_desc,
			     int              pm_format_type,
			     char*            pm_format_data,
			     pid_t            pm_owner_pid)
	Same as trace_create_event() except that all events created
	using this call will be deleted once the process with pm_owner_pid
	exits. Not really useful in kernel space, but essential for
	providing user-space events.

void trace_destroy_event(int pm_event_id)
	Destroys the event with given pm_event_id.

int trace_std_formatted_event(int pm_event_id, ...)
	Instead of having a slew of printk's all around the code,
	pm_event_desc is filled with a printk-like string at the
	event creation and the actual params used to fill this
	string are passed to trace_std_formatted_event(). Be aware
	that this function uses va_start/vsprintf/va_end. The
	resulting string is logged in the trace as such and is visible
	in the trace much like a printk in a log. Except that you can
	place this in paths where printk's can't go and you can be sure
	that events logged with this are delivered even in high
	throughput situations (granted the trace buffer size is adequate).

int trace_raw_event(int   pm_event_id,
                    int   pm_event_size,
                    void* pm_event_data)
	This is the easiest way to log tons of binary data. Just give it
	the size of the data (pm_event_size) and a pointer to it
	(pm_event_data) and it gets written in the trace. This is what
	DProbes uses. The binary data is then formatted in userspace.

All events logged using this API can easily be extracted using LibLTT's
API. There is no requirement to use LTT's own visualization tool,
although you can still use it to see your own custom events.

As with the other traced events, each custom event gets timestamped
(do_gettimeofday) and placed in order of occurrence in the trace buffer.

I've attached an example module that uses the custom event API. See
the Examples directory of the LTT package for an example custom trace
reader which uses LibLTT.

One clear advantage of this API is that you can avoid using any
"#ifdef TRACE" or "#ifdef DEBUG". If the tracing module isn't loaded
or if the trace daemon isn't running, then nothing gets logged.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
--------------4725E3C6E0FD8A48C0D137BE
Content-Type: image/x-xbitmap;
 name="custom1.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="custom1.c"

#define MODULE

#if 0
#define CONFIG_TRACE
#endif

#include <linux/config.h>
#include <linux/module.h>
#include <linux/trace.h>
#include <asm/string.h>

struct delta_event
{
  int   an_int;
  char  a_char;
};

static int alpha_id, omega_id, theta_id, delta_id, rho_id;

int init_module(void)
{
  uint8_t a_byte;
  char a_char;
  int an_int;
  int a_hex;
  char* a_string = "We are initializing the module";
  struct delta_event a_delta_event;

  /* Create events */
  alpha_id = trace_create_event("Alpha",
				"Number %d, String %s, Hex %08X",
				CUSTOM_EVENT_FORMAT_TYPE_STR,
				NULL);
  omega_id = trace_create_event("Omega",
				"Number %d, Char %c",
				CUSTOM_EVENT_FORMAT_TYPE_STR,
				NULL);
  theta_id = trace_create_event("Theta",
				"Plain string",
				CUSTOM_EVENT_FORMAT_TYPE_STR,
				NULL);
  delta_id = trace_create_event("Delta",
				NULL,
				CUSTOM_EVENT_FORMAT_TYPE_HEX,
				NULL);
  rho_id = trace_create_event("Rho",
			      NULL,
			      CUSTOM_EVENT_FORMAT_TYPE_HEX,
			      NULL);

  /* Trace events */
  an_int = 1;
  a_hex = 0xFFFFAAAA;
  trace_std_formatted_event(alpha_id, an_int, a_string, a_hex);
  an_int = 25;
  a_char = 'c';
  trace_std_formatted_event(omega_id, an_int, a_char);
  trace_std_formatted_event(theta_id);
  memset(&a_delta_event, 0, sizeof(a_delta_event));
  trace_raw_event(delta_id, sizeof(a_delta_event), &a_delta_event);
  a_byte = 0x12;
  trace_raw_event(rho_id, sizeof(a_byte), &a_byte);

  return 0;
}

void cleanup_module(void)
{
  uint8_t a_byte;
  char a_char;
  int an_int;
  int a_hex;
  char* a_string = "We are initializing the module";
  struct delta_event a_delta_event;

  /* Trace events */
  an_int = 324;
  a_hex = 0xABCDEF10;
  trace_std_formatted_event(alpha_id, an_int, a_string, a_hex);
  an_int = 789;
  a_char = 's';
  trace_std_formatted_event(omega_id, an_int, a_char);
  trace_std_formatted_event(theta_id);
  memset(&a_delta_event, 0xFF, sizeof(a_delta_event));
  trace_raw_event(delta_id, sizeof(a_delta_event), &a_delta_event);
  a_byte = 0xA4;
  trace_raw_event(rho_id, sizeof(a_byte), &a_byte);

  /* Destroy the events created */
  trace_destroy_event(alpha_id);
  trace_destroy_event(omega_id);
  trace_destroy_event(theta_id);
  trace_destroy_event(delta_id);
  trace_destroy_event(rho_id);
}





--------------4725E3C6E0FD8A48C0D137BE--

