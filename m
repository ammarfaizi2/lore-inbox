Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281919AbRKUQVP>; Wed, 21 Nov 2001 11:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281905AbRKUQVG>; Wed, 21 Nov 2001 11:21:06 -0500
Received: from holomorphy.com ([216.36.33.161]:1177 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S281395AbRKUQU6>;
	Wed, 21 Nov 2001 11:20:58 -0500
Date: Wed, 21 Nov 2001 08:20:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] tree-based bootmem
Message-ID: <20011121082045.A17332@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011117011415.B1180@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011117011415.B1180@holomorphy.com>; from wli@holomorphy.com on Sat, Nov 17, 2001 at 01:14:15AM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2001 at 01:14:15AM -0800, William Lee Irwin III wrote:
> This is a repost including some corrections of a bootmem allocator that
> tracks ranges explicitly, and uses segment trees to assist in searching
> for available memory. Perhaps it is even a new version. Some prior
> reports indicated mail headers were munged, preventing replies and some
> people from seeing it at all.

Some more corrections are needed, and many thanks to Russell King for
assisting me in finding them, and for providing access to a system in
order to debug these issues.

(1) prevent integer overflow in FEASIBLE()
(2) prevent integer overflow in ENDS_ABOVE()
(3) test for !segment_contains_point(optimum, goal)
	in __alloc_bootmem_core() as an additional condition under
	which the the goal should be discounted as a possible starting
	address for the returned interval. The symptom seen without
	the test is an interval that wraps around ULONG_MAX


This patch tested on ARM.


Cheers,
Bill


--- linux/mm/bootmem.c	Sun Nov 18 23:42:26 2001
+++ linux-arm/mm/bootmem.c	Wed Nov 21 07:58:25 2001
@@ -462,14 +440,18 @@
  * that is not sufficient because of alignment constraints.
  */
 
-#define FEASIBLE(seg, len, align) \
-	((RND_UP(segment_start(seg), align) + (len) - 1) <= segment_end(seg))
+#define FEASIBLE(seg, len, align)					\
+(									\
+	(segment_end(seg) >= RND_UP(segment_start(seg), align))		\
+		&&							\
+	((segment_end(seg) - RND_UP(segment_start(seg), align)) > (len))\
+)
 
 #define STARTS_BELOW(seg,goal,align,len) \
 	(RND_UP(segment_start(seg), align) <= (goal))
 
 #define ENDS_ABOVE(seg, goal, align, len) \
-	(segment_end(seg) > ((goal) + (len)))
+	((segment_end(seg) > (goal)) && ((segment_end(seg) - (goal)) > (len)))
 
 #define GOAL_WITHIN(seg,goal,align,len) \
 	(STARTS_BELOW(seg,goal,align,len) && ENDS_ABOVE(seg,goal,align,len))
@@ -635,7 +608,9 @@
 
 	segment_set_endpoints(&reserved, goal, goal + length - 1);
 
-	if(!segment_contains(optimum, &reserved))
+	if(!segment_contains_point(optimum, goal)
+		|| !segment_contains(optimum, &reserved))
+
 		segment_set_endpoints(&reserved,
 				RND_UP(segment_start(optimum), align),
 				RND_UP(segment_start(optimum),align)+length-1);
