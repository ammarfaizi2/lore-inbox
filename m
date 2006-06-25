Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWFYS5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWFYS5p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 14:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWFYS5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 14:57:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11934 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932434AbWFYS5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 14:57:45 -0400
Date: Sun, 25 Jun 2006 11:57:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>,
       Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org
Subject: remove __read_mostly?
Message-Id: <20060625115736.d90e1241.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm thinking we should remove __read_mostly.

Because if we use this everywhere where it's supposed to be used, we end up
with .bss and .data 100% populated with write-often variables, packed
closely together.  The cachelines will really flying around.

IOW: __read_mostly optimises read-mostly variables and pessimises
write-often variables.

We want something which optimises both read-mostly and write-often storage.
 We do that by marking the write-often variables with
__cacheline_aligned_in_smp.

OK?

[Problem is, I don't think any of the make-foo-__read_mostly patches
actually identified _which_ write-often variables were affecting `foo', so
we'll be back to square one.]

[Actually, we should do

	#define __write_often __cacheline_aligned_in_smp

and use __write_often

a) for documentation and

b) so the optimisation can be centrally turned off, for space
   optimisation or for performance validation.]
