Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVC2VVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVC2VVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVC2VTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:19:12 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:10431 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261451AbVC2VQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:16:16 -0500
Message-ID: <4249C418.5040007@engr.sgi.com>
Date: Tue, 29 Mar 2005 13:09:44 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@engr.sgi.com>
CC: johnpol@2ka.mipt.ru, guillaume.thouvenin@bull.net, akpm@osdl.org,
       greg@kroah.com, linux-kernel@vger.kernel.org, efocht@hpce.nec.com,
       linuxram@us.ibm.com, gh@us.ibm.com, elsa-devel@lists.sourceforge.net
Subject: Re: [patch 1/2] fork_connector: add a fork connector
References: <1111745010.684.49.camel@frecb000711.frec.bull.fr>	<20050328134242.4c6f7583.pj@engr.sgi.com>	<1112079856.5243.24.camel@uganda>	<20050329004915.27cd0edf.pj@engr.sgi.com>	<1112092197.5243.80.camel@uganda> <20050329090304.23fbb340.pj@engr.sgi.com>
In-Reply-To: <20050329090304.23fbb340.pj@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

The fork_connector is not designed to solve accounting data collection
problem.

The accounting data collection must be done via a hook from do_exit().
The acct_process() hook invokes do_acct_process() to write BSD
accounting data to disk. CSA needs a similar hook off do_exit() to
collect more accounting data and write to disk in different
accounting records format. This part is not part of fork_connector.

ELSA does not care how accounting data being written to disks. However,
it needs the accounting data being reliably and accurately collected
and written to disk by BSD and/or CSA and it needs the <ppid, pid>
information to aggregate processes. It was never the fork_connector's
intention to piggy back the data to the accounting file.

Thanks,
  - jay



Paul Jackson wrote:
> Evgeniy writes:
> 
>>Here forking connector module "exits" and can handle next fork() on the
>>same CPU.
> 
> 
> Fine ... but it's not about what the fork_connector does.  It's about
> getting the accounting data to disk, if I understand correctly.
> 
> 
>>That is why it is very fast in "fast-path".
> 
> 
> I don't care how fast a tool is.  I care how fast the job gets done.  If
> a tool is only doing part of the job, then we can't decide whether to
> use that tool just based on how fast that part of the job gets done.
> 
> 
>>The most expensive part is cn_netlink_send()/netlink_broadcast(), 
>>with CBUS it is deferred to the safe time,
> 
> 
> This is "safe time" for the immediate purpose of letting the forking
> process continue on its way.  But the deferred work of buffering up the
> data and writing it to disk still needs to be done, pretty soon.  When
> sizing a system to see how many users or jobs I can run on it at a time,
> I will have to include sufficient cpu, memory and disk i/o to handle
> getting this accounting data to disk, right?
> 
> 
>>> 2) Using a modified form of what BSD ACCOUNTING does now:
>>>	- forking process appends single fork data to in-kernel buffer
>>
>>It is not as simple.
>>It takes global locks several times, it access bunch of shared between
>>CPU data.
>>It calls ->stat() and ->write() which may sleep.
> 
> 
> Hmmm ... good points.  The mechanisms in the kernel now (and for the
> last 25 years) to write out BSD ACCOUNTING data may not be numa friendly.
> 
> Perhaps there should be a per-cpu 512 byte buffer, which can gather up 8
> accounting records (64 bytes each) and only call the file system write
> once every 8 task exits.  Or perhaps a per-node buffer, with a spinlock
> to serialize access by the CPUs on that node.  Or perhaps per-node
> accounting files.  Or something like that.
> 
> Guillaume, Jay - do we (you ?) need to make classic BSD ACCOUNTING data
> collection numa friendly?  Based on the various frustrated comments at
> the top of kernel/acct.c, this could be a non-trivial effort to get
> right.  Maybe we need it, but can't afford it.
> 
> And perhaps my proposed variable length records for supplementary
> accounting, such as <parent pid, child pid> from fork, need to allow
> for some way to pad out the rest of a buffer, when the next record
> won't fit entirely.
> 
> 
>>That work is deferred and does not affect in-kernel processes.
> 
> 
> The accounting data collection cannot be deferred for long, perhaps
> just a few minutes.  Not until the data hits the disk can we rest
> indefinitely.  Unless, that is, I don't understand what problem is
> being solved here (quite possible ;).
> 
> 
>>And why userspace fork connector should write data to the disk?
> 
> 
> I NEVER said it should.  I am NOT trying to redesign fork_connector.
> 
> Good grief ... how many times and ways do I have to say this ;)?
> 
> I am asking what is the best tool for accounting data collection,
> which, if I understand correctly, does need to write to disk.
> 

