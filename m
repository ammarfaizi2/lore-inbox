Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318354AbSHFANI>; Mon, 5 Aug 2002 20:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318920AbSHFANI>; Mon, 5 Aug 2002 20:13:08 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:57475 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S318354AbSHFANH>; Mon, 5 Aug 2002 20:13:07 -0400
Date: Tue, 6 Aug 2002 02:16:07 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Jeff Dike <jdike@karaya.com>
Cc: rz@linux-m68k.org, alan@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
Message-Id: <20020806021607.28a75a3d.us15@os.inf.tu-dresden.de>
In-Reply-To: <200208060042.TAA04321@ccure.karaya.com>
References: <20020806003419.3457fcb9.us15@os.inf.tu-dresden.de>
	<200208060042.TAA04321@ccure.karaya.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Aug 2002 19:42:31 -0500
Jeff Dike <jdike@karaya.com> wrote:

> Similarly, with other signals, like the timer, SIGIO, or page faults, it
> would just annull the signal and call into the IRQ system.  Although page 
> faults will be difficult because of the inability to read err or cr3, as 
> you've pointed out.

Jeff,

If my understanding of UML is right, you implement interrupts with socket
pairs where the interrupt handler writes a byte into one end and the other
end receives an async notification (SIGIO). In order to stop the right task
with a SIGIO, you change the socket owner on each context switch using fcntl.

If you have one process per task and a kernel process, the kernel process
cannot change socket ownership over to the next task's process, because it's
not allowed to. Only the process itself could set the ownership to his pid,
but then each task switch would have to be done with a trampoline too.

The issue boils down to how the kernel process can stop a task process in
order to force the task into kernel. You can of course kill (taskpid, SIG)
but that has a race if the task tries to enter kernel at the same time.
SIG will be pending in the task until it is scheduled next.

-Udo.
