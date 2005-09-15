Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbVIOGRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbVIOGRs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 02:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOGRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 02:17:48 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:43408 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932527AbVIOGRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 02:17:47 -0400
Message-ID: <43291204.9060208@cosmosbay.com>
Date: Thu, 15 Sep 2005 08:17:40 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] reorder struct files_struct
References: <20050914191842.GA6315@in.ibm.com> <20050914.125750.05416211.davem@davemloft.net> <20050914201550.GB6315@in.ibm.com> <20050914.132936.105214487.davem@davemloft.net> <43289376.7050205@cosmosbay.com> <20050914220205.GC6237@in.ibm.com> <4328A73B.1080801@cosmosbay.com> <20050914225043.GD6237@in.ibm.com> <4328B013.1010400@cosmosbay.com> <20050915045440.GE6237@in.ibm.com>
In-Reply-To: <20050915045440.GE6237@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma a écrit :
> On Thu, Sep 15, 2005 at 01:19:47AM +0200, Eric Dumazet wrote:
> 
>>Dipankar Sarma a écrit :
>>
>>>On Thu, Sep 15, 2005 at 12:42:03AM +0200, Eric Dumazet wrote:
>>>
>>>
>>>>Dipankar Sarma a écrit :
>>
>>>>If yes, the whole embedded struct fdtable is readonly.
>>>
>>>
>>>But not close_on_exec_init or open_fds_init. We would update them
>>>on open/close.
>>
>>Yes, sure, but those fields are not part of the embedded struct fdtable
> 
> 
> Those fdsets would share a cache line with fdt, fdtable which would
> be invalidated on open/close. So, what is the point in moving
> file_lock ?
> 

The point is that we gain nothing in this case for 32 bits platforms, but we 
gain something on 64 bits platform. And for apps using more than 
NR_OPEN_DEFAULT files we definitly win on both 32bits/64bits.

Maybe moving file_lock just before close_on_exec_init would be a better 
choice, so that 32bits platform small apps touch one cache line instead of two.

sizeof(struct fdtable) = 40/0x28 on 32bits, 72/0x48 on 64 bits

struct files_struct {

/* mostly read */
	atomic_t count; /* offset 0x00 */
	struct fdtable *fdt; /* offset 0x04 (0x08 on 64 bits) */
	struct fdtable fdtab; /* offset 0x08 (0x10 on 64 bits)*/

/* read/written for apps using small number of files */
	fd_set close_on_exec_init; /* offset 0x30 (0x58 on 64 bits) */
	fd_set open_fds_init; /* offset 0x34 (0x60 on 64 bits) */
	struct file * fd_array[NR_OPEN_DEFAULT]; /* offset 0x38 (0x68 on 64 bits */
	spinlock_t file_lock; /* 0xB8 (0x268 on 64 bits) */
	}; /* size = 0xBC (0x270 on 64 bits) */

Moving next_fd from 'struct fdtable' to 'struct files_struct' is also a win 
for 64bits platforms since sizeof(struct fdtable) become 64 : a nice power of 
two, so 64 bytes are allocated instead of 128.

Eric
