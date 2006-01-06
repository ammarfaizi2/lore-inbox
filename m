Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWAFOqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWAFOqa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 09:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWAFOq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 09:46:29 -0500
Received: from [81.2.110.250] ([81.2.110.250]:3492 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751451AbWAFOq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 09:46:29 -0500
Subject: Re: [PATCH, RFC] RCU : OOM avoidance and lower latency
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, netdev@vger.kernel.org
In-Reply-To: <43BE77F1.4090301@cosmosbay.com>
References: <20060105235845.967478000@sorel.sous-sol.org>
	 <20060106004555.GD25207@sorel.sous-sol.org>
	 <Pine.LNX.4.64.0601051727070.3169@g5.osdl.org>
	 <43BE43B6.3010105@cosmosbay.com>
	 <1136554632.30498.7.camel@localhost.localdomain>
	 <43BE77F1.4090301@cosmosbay.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Jan 2006 14:45:12 +0000
Message-Id: <1136558713.30498.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-06 at 15:00 +0100, Eric Dumazet wrote:
> In the case of call_rcu_bh(), you can be sure that the caller cannot afford 
> 'sleeping memory allocations'. Better drop a frame than block the stack, no ?

atomic allocations can't sleep and will fail which is fine. If memory
allocation pressure exists for sleeping allocations because of a large
rcu backlog we want to be sure that the rcu backlog from the networking
stack or other sources does not cause us to OOM kill or take incorrect
action.

So if for example we want to grow a process stack and the memory is
there just stuck in the RCU lists pending recovery we want to let the
RCU recovery happen before making drastic decisions.


