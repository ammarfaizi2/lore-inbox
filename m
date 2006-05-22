Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWEVUOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWEVUOe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 16:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWEVUOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 16:14:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4254 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751163AbWEVUOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 16:14:33 -0400
Date: Mon, 22 May 2006 16:14:28 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: next_timer_interrupt overflow in stop_hz_timer
Message-ID: <20060522201428.GA10346@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <200605212100.k4LL0pCX012928@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605212100.k4LL0pCX012928@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 09:00:51PM +0000, Linux Kernel wrote:
 > commit 92f63cd000059366af18712367216d96180e0ec0
 > tree 4f88c3875afaa8183d6cfcff685e03ac7684d82d
 > parent 0662b71322e211dba9a4bc0e6fbca7861a2b5a7d
 > author Martin Schwidefsky <schwidefsky@de.ibm.com> Sun, 21 May 2006 05:00:25 -0700
 > committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 22 May 2006 02:59:21 -0700
 > 
 > [PATCH] s390: next_timer_interrupt overflow in stop_hz_timer
 > 
 > The 32 bit unsigned substraction (next - jiffies) in stop_hz_timer can
 > overflow if jiffies gets advanced between next_timer_interrupt and the read
 > under the xtime lock.  The cast to a u64 then results in a large value
 > which causes the cpu to wait too long.  Fix this by casting next and
 > jiffies independently to u64 before subtracting them.
 > 
 > (Spotted by Zachary Amsden <zach@vmware.com>)
 > 
 > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
 > Signed-off-by: Andrew Morton <akpm@osdl.org>
 > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
 > 
 >  arch/s390/kernel/time.c |    2 +-
 >  1 files changed, 1 insertion(+), 1 deletion(-)
 > 
 > diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
 > index 029f099..ce19ad4 100644
 > --- a/arch/s390/kernel/time.c
 > +++ b/arch/s390/kernel/time.c
 > @@ -272,7 +272,7 @@ static inline void stop_hz_timer(void)
 >  	next = next_timer_interrupt();
 >  	do {
 >  		seq = read_seqbegin_irqsave(&xtime_lock, flags);
 > -		timer = (__u64)(next - jiffies) + jiffies_64;
 > +		timer = (__u64 next) - (__u64 jiffies) + jiffies_64;
 >  	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 >  	todval = -1ULL;
 >  	/* Be careful about overflows. */


arch/s390/kernel/time.c: In function 'stop_hz_timer':
arch/s390/kernel/time.c:275: error: expected ')' before 'next'
arch/s390/kernel/time.c:275: error: expected ')' before 'jiffies'

		Dave

-- 
http://www.codemonkey.org.uk
