Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131226AbQIBQo4>; Sat, 2 Sep 2000 12:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131221AbQIBQor>; Sat, 2 Sep 2000 12:44:47 -0400
Received: from [203.46.105.129] ([203.46.105.129]:12807 "HELO pornstar.not.very.secure.org") by vger.kernel.org with SMTP id <S131219AbQIBQoh>; Sat, 2 Sep 2000 12:44:37 -0400
Subject: error in arch/i386/kernel/ptrace.c (subtle)
To: linux-kernel@vger.kernel.org
Date: Sun, 3 Sep 100 01:50:18 +1000 (EST)
Cc: silvio@big.net.au
X-Mailer: ELM [version 2.4ME+ PL31 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20000902155021.51C9E4917@pornstar.not.very.secure.org>
From: silvio@big.net.au (Silvio Cesare)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  This is my first post to this list (not that i'm even subscribed) and am
very new to linux internals so apologies up front :)

There is a subtle bug in the behaviour of ptrace when modifying the EIP
register.  Noteably, if the eip changes and a syscall was interrupted, the
signal handling code will subtract 2 from the eip thinking its trying to
restart the syscall (obviously, only on systems that restart slow syscalls).
This behaviour could cause problems with debuggers that change the execution
path.

My fix would be to change orig_eax to -1 if the eip register is modified.
Thus the signal handling code wouldnt think it needed to restart any syscalls.
This is untested code btw.

in the putreg function

	case EIP:
		put_stack_long(child, 4*ORIG_EAX - sizeof(struct pt_regs), -1);
		break;

I believe that is all that is required, but since I'd hardly call myself a
kernel hacker I'll let the experts decide.  Its highly likely that many other
unix systems have this same problem.

Please reply to this email personally, as I'm not a subscriber to this
mailing list.

--
Silvio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
