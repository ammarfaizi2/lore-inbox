Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292664AbSCDSds>; Mon, 4 Mar 2002 13:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292665AbSCDSda>; Mon, 4 Mar 2002 13:33:30 -0500
Received: from ns.ithnet.com ([217.64.64.10]:25348 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S292660AbSCDSdG>;
	Mon, 4 Mar 2002 13:33:06 -0500
Date: Mon, 4 Mar 2002 19:18:04 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: riel@conectiva.com.br, andrea@suse.de, phillips@bonn-fries.net,
        davidsen@tmr.com, mfedyk@matchmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-Id: <20020304191804.2e58761c.skraw@ithnet.com>
In-Reply-To: <190330000.1015261149@flay>
In-Reply-To: <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com>
	<190330000.1015261149@flay>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Mar 2002 08:59:10 -0800
"Martin J. Bligh" <Martin.Bligh@us.ibm.com> wrote:

> 2) We can do local per-node scanning - no need to bounce
> information to and fro across the interconnect just to see what's
> worth swapping out.

Well, you can achieve this by "attaching" the nodes' local memory (zone) to its cpu and let the vm work preferably only on these attached zones (regarding the list scanning and the like). This way you have no interconnect traffic generated. But this is in no way related to rmap.

> I suspect that the performance of NUMA under memory pressure
> without the rmap stuff will be truly horrific, as we decend into 
> a cache-trashing page transfer war. 

I guess you are right for the current implementation, but I doubt rmap will be a _real_ solution to your problem.

> I can't see any way to fix this without some sort of rmap - any
> other suggestions as to how this might be done?

As stated above: try to bring in per-node zones that are preferred by their cpu. This can work equally well for UP,SMP and NUMA (maybe even for cluster).
UP=every zone is one or more preferred zone(s)
SMP=every zone is one or more preferred zone(s)
NUMA=every cpu has one or more preferred zone(s), but can walk the whole zone-list if necessary.
cluster=every cpu has one or more preferred zone(s), but cannot walk the whole zone-list.

Preference is implemented as simple list of cpu-ids attached to every memory zone. This is for being able to see the whole picture. Every cpu has a private list of (preferred) zones which is used by vm for the scanning jobs (swap et al). This way there is no need to touch interconnection. If you are really in a bad situation you can alway go back to the global list and do whatever is needed.
This sounds pretty scalable and runtime-configurable. And not related to rmap...

Beat me,
Stephan

PS: Drop clusters from the discussion, I know this would become weird.

