Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbTJNSm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbTJNSm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:42:29 -0400
Received: from mail3.iserv.net ([204.177.184.153]:65217 "EHLO mail3.iserv.net")
	by vger.kernel.org with ESMTP id S262906AbTJNSmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:42:20 -0400
Message-ID: <3F8C438B.9040802@didntduck.org>
Date: Tue, 14 Oct 2003 14:42:19 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Lattner <sabre@nondot.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
References: <Pine.LNX.4.44.0310141320020.3869-100000@nondot.org>
In-Reply-To: <Pine.LNX.4.44.0310141320020.3869-100000@nondot.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lattner wrote:

>My compiler is generating accesses off the bottom of the stack (address
>below %esp).  Is there some funny kernel interaction that I should be
>aware of with this?  I'm periodically getting segfaults.
>
>Example:
>
>int main() {
>   int test[4000];
>...
>   return 0;
>}
>
>Generated code:
>        .intel_syntax
>...
>main:
>        mov DWORD PTR [%ESP - 16004], %EBP    # Save EBP to stack
>        mov %EBP, %ESP                        # Set up EBP
>        sub %ESP, 16004                       # Finally adjust ESP
>        lea %EAX, DWORD PTR [%EBP - 16000]    # Get the address of the array
>...
>        mov %EAX, 0                           # Setup return value
>        mov %ESP, %EBP                        # restore ESP
>        mov %EBP, DWORD PTR [%ESP - 16004]    # Restore EBP from stack
>        ret
>
>This seems like perfectly valid X86 code (though unconventional), but it
>is causing segfaults pretty consistently (on the first instruction).
>Does the linux kernel assume that page faults will be above the stack
>pointer if the stack needs to be expanded?
>
>Thanks,
>
>-Chris
>
>  
>
 From arch/i386/mm/fault.c:
                /*
                 * accessing the stack below %esp is always a bug.
                 * The "+ 32" is there due to some instructions (like
                 * pusha) doing post-decrement on the stack and that
                 * doesn't show up until later..
                 */
                if (address + 32 < regs->esp)
                        goto bad_area;

--
                Brian Gerst

