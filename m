Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbRFHIr5>; Fri, 8 Jun 2001 04:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263932AbRFHIrr>; Fri, 8 Jun 2001 04:47:47 -0400
Received: from t2.redhat.com ([199.183.24.243]:41980 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S262835AbRFHIri>; Fri, 8 Jun 2001 04:47:38 -0400
To: Pavel Kankovsky <peak@argo.troja.mff.cuni.cz>,
        Mike Coleman <mkc@mathdogs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PTRACE_ATTACH breaks wait4() 
In-Reply-To: Message from Pavel Kankovsky <peak@argo.troja.mff.cuni.cz> 
   of "Thu, 07 Jun 2001 22:39:43 +0200." <20010607223921.D94.0@argo.troja.mff.cuni.cz> 
Date: Fri, 08 Jun 2001 09:47:20 +0100
Message-ID: <28783.991990040@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an idea for getting around this problem, but it's only half implemented
at the moment (I use it for implementing a Wine server in the kernel). It
involves having a list things called task ornaments attached to each
process. Each ornament has a table of event notification methods (so it can be
informed about fork, execve, signal and exit events). Signal event
notification methods are able to prevent a signal from propegating further
down the chain, and the parent's wait handler would be the last element in
this list. When a process attaches with ptrace(), it would insert another
ornament into this list, before the parent's ornament. This means (a) the
process doesn't have to be reparented, and (b) more than one debugger can
actually attach to a process (eg: strace and gdb both).

This would, however, mean that wait*() would have to not only look at a
process's list of children, but also it's list of processes it has ornamented
via ptrace

David
