Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWEHQCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWEHQCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 12:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWEHQCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 12:02:13 -0400
Received: from dvhart.com ([64.146.134.43]:57057 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932411AbWEHQCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 12:02:12 -0400
Message-ID: <445F6B7E.8030804@mbligh.org>
Date: Mon, 08 May 2006 09:02:06 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Jason Schoonover <jasons@pioneer-pra.com>, linux-kernel@vger.kernel.org
Subject: Re: High load average on disk I/O on 2.6.17-rc3
References: <200605051010.19725.jasons@pioneer-pra.com> <20060507095039.089ad37c.akpm@osdl.org> <445F548A.703@mbligh.org> <1147100149.2888.37.camel@laptopd505.fenrus.org> <20060508152255.GF1875@harddisk-recovery.com> <1147102290.2888.41.camel@laptopd505.fenrus.org> <20060508154217.GH1875@harddisk-recovery.com>
In-Reply-To: <20060508154217.GH1875@harddisk-recovery.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> On Mon, May 08, 2006 at 05:31:29PM +0200, Arjan van de Ven wrote:
> 
>>On Mon, 2006-05-08 at 17:22 +0200, Erik Mouw wrote:
>>
>>>... except that any kernel < 2.6 didn't account tasks waiting for disk
>>>IO.
>>
>>they did. It was "D" state, which counted into load average.
> 
> 
> They did not or at least to a much lesser extent. That's the reason why
> ZenIV.linux.org.uk had a mail DoS during the last FC release and why we
> see load average questions on lkml.
> 
> I've seen it on our servers as well: when using 2.4 and doing 50 MB/s
> to disk (through NFS), the load just was slightly above 0. When we
> switched the servers to 2.6 it went to ~16 for the same disk usage.

Looks like both count it, or something stranger is going on.

2.6.16:

static unsigned long count_active_tasks(void)
{
         return (nr_running() + nr_uninterruptible()) * FIXED_1;
}

2.4.0:

static unsigned long count_active_tasks(void)
{
         struct task_struct *p;
         unsigned long nr = 0;

         read_lock(&tasklist_lock);
         for_each_task(p) {
                 if ((p->state == TASK_RUNNING ||
                      (p->state & TASK_UNINTERRUPTIBLE)))
                         nr += FIXED_1;
         }
         read_unlock(&tasklist_lock);
         return nr;
}

