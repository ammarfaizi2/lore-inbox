Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUJNTgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUJNTgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUJNTc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:32:59 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:44042 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267417AbUJNTbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:31:53 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Dhiman, Gaurav" <Gaurav.Dhiman@ca.com>, "Jan Hudec" <bulb@ucw.cz>,
       "aq" <aquynh@gmail.com>
Subject: Re: Kernel stack
Date: Thu, 14 Oct 2004 22:31:44 +0300
User-Agent: KMail/1.5.4
Cc: "suthambhara nagaraj" <suthambhara@gmail.com>,
       "main kernel" <linux-kernel@vger.kernel.org>,
       "kernel" <kernelnewbies@nl.linux.org>
References: <577528CFDFEFA643B3324B88812B57FE305968@inhyms21.ca.com>
In-Reply-To: <577528CFDFEFA643B3324B88812B57FE305968@inhyms21.ca.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410142231.44916.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 October 2004 07:35, Dhiman, Gaurav wrote:
> Yes it definitely can happen (and I think this is the way to do it) that
> SS in process's TSS is initialized to the memory address just next to
> task_struct (as the kernel stack can grow downwards till this limit)

SS:0 points to 0x00000000 linear address. IOW: SSdescr.base == 0

> while the forking of a process and also sets the SP to the fixed offset
> from task_struct from where the kernel stack starts growing downwards
> (as you mentioned kernel stack starts from there). Now whenever this
> process will be scheduled by the scheduler or a process enters the
> kernel mode, CPU's SS and SP registers are re-set to the SS and SP
> elements in TSS of that process.

On task switch it is unnnecessary if SS does not really change (which
is happening 99.9% of the time). At user->kernel mode, yes, CPU
loads SS from TSS.ss field.

> At the time of scheduling, scheduler also change the TSS descriptor for
> that CPU on which the process is going to be scheduled. It changes this
> TSS descriptor in GDT to point to the TSS of the selected process.

There is no "TSS of the selected process". There is only one TSS per CPU.
(Intel didn't plan for this arrangement, but Linux nevertheless uses it).

Because of this, scheduler does not "change the TSS descriptor for
that CPU on which the process is going to be scheduled". It simply patches
some values in current CPU's TSS segment. This is way faster that executing
microcoded TSS change.

> Correct me if I am wrong.
>
> [overquoting snipped]
--
vda

