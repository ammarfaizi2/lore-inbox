Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129524AbQKYRHJ>; Sat, 25 Nov 2000 12:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131357AbQKYRG7>; Sat, 25 Nov 2000 12:06:59 -0500
Received: from relay02.valueweb.net ([216.219.253.236]:25352 "EHLO
        relay02.valueweb.net") by vger.kernel.org with ESMTP
        id <S131354AbQKYRGt>; Sat, 25 Nov 2000 12:06:49 -0500
Message-ID: <3A1FEBAC.2C2EA3ED@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Announce: DProbes/LTT interoperability and custom event logging
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sat, 25 Nov 2000 11:36:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As you've probably seen from Richard's announcement, it is now
possible to use the LTT/DProbes pair to dynamically insert trace
points anywhere in the system.

That said, the added functionnality to LTT also enables kernel/
module programmers to dynamically add trace types and log the
corresponding events in the trace.

The following functions have been added to provide this capability:
int  trace_create_event
       (char*            /* String describing event type */,
	char*            /* String to format event description */,
	event_data_desc* /* Table containing data formatting details */);
void trace_destroy_event
       (int           /* The event ID given by trace_create_event() */);
void trace_reregister_custom_events
       (void);
int  trace_formatted_event
       (int           /* The event ID given by trace_create_event() */,
	...           /* The parameters to be printed out in the event string */);
int  trace_raw_event
       (int           /* The event ID given by trace_create_event() */,
	int           /* The size of the raw data */,
	void*         /* Pointer to the raw event data */);


The following is an example module that uses this functionnality to
log custom events in the trace:
------------------------------------------------------------------------------------
#define MODULE

#define CONFIG_TRACE

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
				NULL);
  omega_id = trace_create_event("Omega",
				"Number %d, Char %c",
				NULL);
  theta_id = trace_create_event("Theta",
				"Plain string",
				NULL);
  delta_id = trace_create_event("Delta",
				NULL,
				NULL);
  rho_id = trace_create_event("Rho",
			      NULL,
			      NULL);

  /* Trace events */
  an_int = 1;
  a_hex = 0xFFFFAAAA;
  trace_formatted_event(alpha_id, an_int, a_string, a_hex);
  an_int = 25;
  a_char = 'c';
  trace_formatted_event(omega_id, an_int, a_char);
  trace_formatted_event(theta_id);
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
  trace_formatted_event(alpha_id, an_int, a_string, a_hex);
  an_int = 789;
  a_char = 's';
  trace_formatted_event(omega_id, an_int, a_char);
  trace_formatted_event(theta_id);
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
------------------------------------------------------------------------------------

This is the resulting output in the trace dump:
Memory 			975,040,616,826,952 	494 	14 	PAGE ALLOC ORDER : 0
Memory 			975,040,616,826,957 	494 	14 	PAGE FREE ORDER : 0
Memory 			975,040,616,826,958 	494 	14 	PAGE FREE ORDER : 0
Event creation 		975,040,616,826,964 	494 	146 	NEW EVENT TYPE : Alpha
Event creation 		975,040,616,826,967 	494 	146 	NEW EVENT TYPE : Omega
Event creation 		975,040,616,826,970 	494 	146 	NEW EVENT TYPE : Theta
Event creation 		975,040,616,826,972 	494 	146 	NEW EVENT TYPE : Delta
Event creation 		975,040,616,826,974 	494 	146 	NEW EVENT TYPE : Rho
Alpha 			975,040,616,826,988 	494 	80 	Number 1, String We are initializing the module, Hex FFFFAAAA
Omega 			975,040,616,826,991 	494 	36 	Number 25, Char c
Theta 			975,040,616,826,993 	494 	31 	Plain string
Delta 			975,040,616,826,994 	494 	26 	00 00 00 00 00 00 00 00 
Rho 			975,040,616,826,995 	494 	19 	12 
Syscall exit 		975,040,616,826,996 	494 	6 	
Syscall entry 		975,040,616,827,028 	494 	14 	SYSCALL : close; EIP : 0x0804AE41


You can find more info on this custom event logging capability on
LTT's web site at: http://www.opersys.com/LTT

You can find DProbes at:
http://oss.software.ibm.com/developer/opensource/linux/projects/dprobes/

Best regards

Karim

===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
