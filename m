Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWDTORd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWDTORd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 10:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWDTORd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 10:17:33 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:2230 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S1750765AbWDTORd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 10:17:33 -0400
DomainKey-Signature: s=s768; d=fujitsu-siemens.com; c=nofws; q=dns; b=yTa1eEohLkr6LTAtc15o0hbprq+ouIho/BCq8ZHsAdM2C1r3DkvACcGX/vCg7DjXLQ77zRU9QcxX6ryFLm6T1H4NQLJlAABB0A1dqQfF6TkKkERirx0hBjAzoWSzgoMh;
X-SBRSScore: None
X-IronPort-AV: i="4.04,141,1144015200"; 
   d="scan'208"; a="30329875:sNHT177770072"
Message-ID: <444797F8.6020509@fujitsu-siemens.com>
Date: Thu, 20 Apr 2006 16:17:28 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens wrote:
>>Add PTRACE_SYSCALL_MASK, which allows system calls to be selectively
>>traced.  It takes a bitmask and a length.  A system call is traced
>>if its bit is one.  Otherwise, it executes normally, and is
>>invisible to the ptracing parent.
>>[...]
>>+int set_syscall_mask(struct task_struct *child, char __user *mask,
>>+		     unsigned long len)
>>+{
>>+	int i, n = (NR_syscalls + 7) / 8;
>>+	char c;
>>+
>>+	if(len > n){
>>+		for(i = NR_syscalls; i < len * 8; i++){
>>+			get_user(c, &mask[i / 8]);
>>+			if(!(c & (1 << (i % 8)))){
>>+				printk("Out of range syscall at %d\n", i);
>>+				return -EINVAL;
>>+			}
>>+		}
>>+
>>+		len = n;
>>+	}
> 
> 
> Since it's quite likely that len > n will be true (e.g. after installing the
> latest version of your debug tool) it would be better to silently ignore all
> bits not within the range of NR_syscalls.
> There is no point in flooding the console. The tracing process won't see any
> of the non existant syscalls it requested to see anyway.

Shouldn't 'len' better be the number of bits in the mask than the number of chars?
Assume a syscall newly added to UML would be a candidate for processing on the host,
but the incremented NR_syscalls still would result in the same number of bytes. Also
assume, host doesn't yet have that new syscall. Current implementation doesn't catch
the fact, that host can't execute that syscall.

OTOH, I think UML shouldn't send the entire mask, but relevant part only. The missing
end is filled with 0xff by host anyway. So it would be enough to send the mask up to the
highest bit representing a syscall, that needs to be executed by host. (currently, that
is __NR_gettimeofday). If UML would do so, no more problem results from UML having
a higher NR_syscall than the host (as long as the new syscalls are to be intercepted
and executed by UML)

A greater problem might be a process in UML, that calls an invalid syscall number. AFAICS
syscall number (orig_eax) isn't checked before it is used in do_syscall_trace to address
syscall_mask. This might result in a crash.

Bodo
