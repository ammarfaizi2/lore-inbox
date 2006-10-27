Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423694AbWJ0FwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423694AbWJ0FwJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 01:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423692AbWJ0FwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 01:52:09 -0400
Received: from mis011.exch011.intermedia.net ([64.78.21.10]:58418 "EHLO
	mis011.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1423668AbWJ0FwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 01:52:07 -0400
Message-ID: <45419E7F.6040201@qumranet.com>
Date: Fri, 27 Oct 2006 07:51:59 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org, kvm-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/13] KVM: userspace interface
References: <4540EE2B.9020606@qumranet.com> <20061026172256.6DEB7A0209@cleopatra.q> <200610270051.43477.arnd@arndb.de>
In-Reply-To: <200610270051.43477.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Oct 2006 05:52:06.0664 (UTC) FILETIME=[08E59880:01C6F98C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Thursday 26 October 2006 19:22, Avi Kivity wrote:
>   
>> +
>> +/* for KVM_RUN */
>> +struct kvm_run {
>> +       /* in */
>> +       __u32 vcpu;
>> +       __u32 emulated;  /* skip current instruction */
>> +       __u32 mmio_completed; /* mmio request completed */
>> +
>> +       /* out */
>> +       __u32 exit_type;
>> +       __u32 exit_reason;
>> +       __u32 instruction_length;
>> +       union {
>> +               /* KVM_EXIT_UNKNOWN */
>> +               struct {
>> +                       __u32 hardware_exit_reason;
>> +               } hw;
>> +               /* KVM_EXIT_EXCEPTION */
>> +               struct {
>> +                       __u32 exception;
>> +                       __u32 error_code;
>> +               } ex;
>> +               /* KVM_EXIT_IO */
>> +               struct {
>> +#define KVM_EXIT_IO_IN  0
>> +#define KVM_EXIT_IO_OUT 1
>> +                       __u8 direction;
>> +                       __u8 size; /* bytes */
>> +                       __u8 string;
>> +                       __u8 string_down;
>> +                       __u8 rep;
>> +                       __u8 pad;
>> +                       __u16 port;
>> +                       __u64 count;
>> +                       union {
>> +                               __u64 address;
>> +                               __u32 value;
>> +                       };
>> +               } io;
>> +               struct {
>> +               } debug;
>> +               /* KVM_EXIT_MMIO */
>> +               struct {
>> +                       __u64 phys_addr;
>> +                       __u8  data[8];
>> +                       __u32 len;
>> +                       __u8  is_write;
>> +               } mmio;
>> +       };
>> +};
>>     
>
> This data structure looks like it can become maintenance problem. It's
> already sufficiently complex that I would assume that you need to extend
> it in the future even further, which is hard to do in a compatible
> way. How confident are you that, for a given exit reason, you don't need
> to add or extend the existing fields further, thereby breaking the ABI?
> Do you have a plan how to deal with such breakage?
>
>   

I guess we can reserve some extra space, and if we need even more space 
a new exit reason can specify a pointer to receive the exit data.

Of course, userspace should not get an unexpected exit reason.  I'm not 
worried about the short term, since it's likely there will only be a 
single user (modified qemu), long term we'll have userspace enable new 
features explicitly.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

