Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTDERBU (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 12:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbTDERBT (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 12:01:19 -0500
Received: from opersys.com ([64.40.108.71]:15368 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261707AbTDERBS (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 12:01:18 -0500
Message-ID: <3E8F0DEF.C50FB29C@opersys.com>
Date: Sat, 05 Apr 2003 12:10:07 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: linux-kernel@vger.kernel.org, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [RFC/FYI] reliable markers (hooks/probes/taps/...)
References: <20030403070758.A18709@almesberger.net> <20030404224652.A19288@almesberger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Werner Almesberger wrote:
> 
> I wrote:
> > Here's a pretty light-weight approach I call "reliable markers":
> 
> Turns out that the memory clobber didn't make them particularly
> reliable. Here's a better version. Usage:
> 
> MARKER(label_name,var...);
> 
> Where var... is an optional comma-separated list of arguments or
> variables that may be accessed (read or modified) while at this
> breakpoint.
> 
> (This is just for demonstration. For serious use, one would generate
> a markers.h that can handle more than just four arguments.)

Very interesting.

We've already got a small program that does this for LTT statements
which we plan to use in the future: genevent.
http://www.listserv.shafik.org/pipermail/ltt-dev/2003-January/000408.html

genevent is pretty much straight forward. You type:
$ ./genevent default.event
$ ls default*
-rw-rw-r--    1 karim    karim         392 Apr  5 11:58 default.c
-rw-rw-r--    1 karim    karim        6892 Apr  5 11:56 default.event
-rw-rw-r--    1 karim    karim       18328 Apr  5 11:58 default.h

The default.event file contains declarations about each event. Here's
an example:
//TRACE_EV_SYSCALL_ENTRY
event(TRACE_EV_SYSCALL_ENTRY, "Entry in a given system call",
      field(syscall_id, "Syscall entry number in entry.S", uint(1)),
      field(address, "Address from which call was made", uint(4))
     );

And genevent creates the following entries in the default.h for it:
/****  structure and trace function for event: TRACE_EV_SYSCALL_ENTRY  ****/

__attribute__((packed)) struct TRACE_EV_SYSCALL_ENTRY_default_1{
  uint8_t syscall_id; /* Syscall entry number in entry.S */
  uint32_t address; /* Address from which call was made */
};

static inline void trace_default_TRACE_EV_SYSCALL_ENTRY(uint8_t syscall_id, uint32_t address){
  int bufLength = sizeof(struct TRACE_EV_SYSCALL_ENTRY_default_1);
  char buff[bufLength];
  struct TRACE_EV_SYSCALL_ENTRY_default_1 * __1 = (struct TRACE_EV_SYSCALL_ENTRY_default_1 *)buff;

  //initialize structs
  __1->syscall_id =  syscall_id;
  __1->address =  address;


  //call trace function
  trace_new(facility_default, TRACE_EV_SYSCALL_ENTRY, bufLength, buff);
};

Also, genevent automatically generates an enum for all the events
described in the .event file:
enum default_event {
  TRACE_EV_START,
  TRACE_EV_SYSCALL_ENTRY,
  TRACE_EV_SYSCALL_EXIT,
  TRACE_EV_TRAP_ENTRY,
...

Obviously the word "trace" is used throughout, but it can easily be
replaced by "marker" if this mechanism were generalized.

The intent is to have a .event file in every directory where there are
traced events in files (which are the equivalent of "markers" in your
scheme). During the build, the various headers would be created and
all the code would be generated on the fly.

Of course this is just a begining. We're open to suggestions and
contributions.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
