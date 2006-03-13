Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWCMTyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWCMTyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWCMTyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:54:13 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:18955 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932403AbWCMTyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:54:12 -0500
Message-ID: <4415CDE2.5010402@vmware.com>
Date: Mon, 13 Mar 2006 11:54:10 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VMI Interface Proposal Documentation for I386, Part 3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Time Interface.

     In a virtualized environment, virtual machines (VM) will time share
     the system with each other and with other processes running on the
     host system.  Therefore, a VM's virtual CPUs (VCPUs) will be
     executing on the host's physical CPUs (PCPUs) for only some portion
     of time.  This section of the VMI exposes a paravirtual view of
     time to the guest operating systems so that they may operate more
     effectively in a virtual environment.  The interface also provides
     a way for the VCPUs to set alarms in this paravirtual view of time.

     Time Domains:

     a) Wallclock Time:

     Wallclock time exposed to the VM through this interface indicates
     the number of nanoseconds since epoch, 1970-01-01T00:00:00Z (ISO
     8601 date format).  If the host's wallclock time changes (say, when
     an error in the host's clock is corrected), so does the wallclock
     time as viewed through this interface.

     b) Real Time:

     Another view of time accessible through this interface is real
     time.  Real time always progresses except for when the VM is
     stopped or suspended.  Real time is presented to the guest as a
     counter which increments at a constant rate defined (and presented)
     by the hypervisor.  All the VCPUs of a VM share the same real time
     counter.

     The unit of the counter is called "cycles".  The unit and initial
     value (corresponding to the time the VM enters para-virtual mode)
     are chosen by the hypervisor so that the real time counter will not
     rollover in any practical length of time.  It is expected that the
     frequency (cycles per second) is chosen such that this clock
     provides a "high-resolution" view of time.  The unit can only
     change when the VM (re)enters paravirtual mode.

     c) Stolen time and Available time:

     A VCPU is always in one of three states: running, halted, or ready.
     The VCPU is in the 'running' state if it is executing.  When the
     VCPU executes the HLT interface, the VCPU enters the 'halted' state
     and remains halted until there is some work pending for the VCPU
     (e.g. an alarm expires, host I/O completes on behalf of virtual
     I/O).  At this point, the VCPU enters the 'ready' state (waiting
     for the hypervisor to reschedule it).  Finally, at any time when
     the VCPU is not in the 'running' state nor the 'halted' state, it
     is in the 'ready' state.

     For example, consider the following sequence of events, with times
     given in real time:

     (Example 1)

     At 0 ms, VCPU executing guest code.
     At 1 ms, VCPU requests virtual I/O.
     At 2 ms, Host performs I/O for virtual I/0.
     At 3 ms, VCPU executes VMI_Halt.
     At 4 ms, Host completes I/O for virtual I/O request.
     At 5 ms, VCPU begins executing guest code, vectoring to the interrupt
              handler for the device initiating the virtual I/O.
     At 6 ms, VCPU preempted by hypervisor.
     At 9 ms, VCPU begins executing guest code.

     From 0 ms to 3 ms, VCPU is in the 'running' state.  At 3 ms, VCPU
     enters the 'halted' state and remains in this state until the 4 ms
     mark.  From 4 ms to 5 ms, the VCPU is in the 'ready' state.  At 5
     ms, the VCPU re-enters the 'running' state until it is preempted by
     the hypervisor at the 6 ms mark.  From 6 ms to 9 ms, VCPU is again
     in the 'ready' state, and finally 'running' again after 9 ms.

     Stolen time is defined per VCPU to progress at the rate of real
     time when the VCPU is in the 'ready' state, and does not progress
     otherwise.  Available time is defined per VCPU to progress at the
     rate of real time when the VCPU is in the 'running' and 'halted'
     states, and does not progress when the VCPU is in the 'ready'
     state.

     So, for the above example, the following table indicates these time
     values for the VCPU at each ms boundary:

     Real time    Stolen time    Available time
      0            0              0
      1            0              1
      2            0              2
      3            0              3
      4            0              4
      5            1              4
      6            1              5
      7            2              5
      8            3              5
      9            4              5
     10            4              6

     Notice that at any point:
        real_time == stolen_time + available_time

     Stolen time and available time are also presented as counters in
     "cycles" units.  The initial value of the stolen time counter is 0.
     This implies the initial value of the available time counter is the
     same as the real time counter.

     Alarms:

     Alarms can be set (armed) against the real time counter or the
     available time counter. Alarms can be programmed to expire once
     (one-shot) or on a regular period (periodic).  They are armed by
     indicating an absolute counter value expiry, and in the case of a
     periodic alarm, a non-zero relative period counter value.  [TBD:
     The method of wiring the alarms to an interrupt vector is dependent
     upon the virtual interrupt controller portion of the interface.
     Currently, the alarms may be wired as if they are attached to IRQ0
     or the vector in the local APIC LVTT.  This way, the alarms can be
     used as drop in replacements for the PIT or local APIC timer.]

     Alarms are per-vcpu mechanisms.  An alarm set by vcpu0 will fire
     only on vcpu0, while an alarm set by vcpu1 will only fire on vcpu1.
     If an alarm is set relative to available time, its expiry is a
     value relative to the available time counter of the vcpu that set
     it.

     The interface includes a method to cancel (disarm) an alarm.  On
     each vcpu, one alarm can be set against each of the two counters
     (real time and available time).  A vcpu in the 'halted' state
     becomes 'ready' when any of its alarm's counters reaches the
     expiry.

     An alarm "fires" by signaling the virtual interrupt controller.  An
     alarm will fire as soon as possible after the counter value is
     greater than or equal to the alarm's current expiry.  However, an
     alarm can fire only when its vcpu is in the 'running' state.

     If the alarm is periodic, a sequence of expiry values,

      E(i) = e0 + p * i ,  i = 0, 1, 2, 3, ...

     where 'e0' is the expiry specified when setting the alarm and 'p'
     is the period of the alarm, is used to arm the alarm.  Initially,
     E(0) is used as the expiry.  When the alarm fires, the next expiry
     value in the sequence that is greater than the current value of the
     counter is used as the alarm's new expiry.

     One-shot alarms have only one expiry.  When a one-shot alarm fires,
     it is automatically disarmed.

     Suppose an alarm is set relative to real time with expiry at the 3
     ms mark and a period of 2 ms.  It will expire on these real time
     marks: 3, 5, 7, 9.  Note that even if the alarm does not fire
     during the 5 ms to 7 ms interval, the alarm can fire at most once
     during the 7 ms to 9 ms interval (unless, of course, it is
     reprogrammed).

     If an alarm is set relative to available time with expiry at the 1
     ms mark (in available time) and with a period of 2 ms, then it will
     expire on these available time marks: 1, 3, 5.  In the scenario
     described in example 1, those available time values correspond to
     these values in real time: 1, 3, 6.

