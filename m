Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVAKLK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVAKLK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 06:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVAKLKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 06:10:25 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:1541 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S262712AbVAKLKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 06:10:19 -0500
Date: Tue, 11 Jan 2005 12:10:15 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Alex LIU <alex.liu@st.com>
Cc: "'Andries Brouwer'" <aebr@win.tue.nl>, "'Pavel Machek'" <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: The purpose of PT_TRACESYSGOOD
Message-ID: <20050111111015.GC2760@pclin040.win.tue.nl>
References: <20050111023003.GA2760@pclin040.win.tue.nl> <00ac01c4f7a6$c79e03f0$ac655e0a@sha.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ac01c4f7a6$c79e03f0$ac655e0a@sha.st.com>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: pastinakel.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> /*
>>  * A child stopped at a syscall has status as if it received SIGTRAP.
>>  * In order to distinguish between SIGTRAP and syscall, some kernel
>>  * versions have the PTRACE_O_TRACESYSGOOD option, that sets an extra
>>  * bit 0x80 in the syscall case.
>>  */

> Then I think the tracing thread should call the ptrace_request to set
> PTRACE_O_TRACESYSGOOD flag of the traced thread first before
> ptrace(PTRACE_SYSCALL...) ,right?

Yes.

>From a baby ptrace demo:

#define SIGSYSTRAP      (SIGTRAP | sysgood_bit)

int sysgood_bit = 0;

void set_sysgood(pid_t p) {
#ifdef PTRACE_O_TRACESYSGOOD
        int i = ptrace(PTRACE_SETOPTIONS, p, 0, (void*) PTRACE_O_TRACESYSGOOD);
        if (i == 0)
                sysgood_bit = 0x80;
        else
                perror("PTRACE_O_TRACESYSGOOD");
#endif
}

and now the signal SIGSYSTRAP signifies a system call when the sysgood bit
was implemented, anything different from SIGSYSTRAP is guaranteed to be a signal.

