Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131985AbRDEFQu>; Thu, 5 Apr 2001 01:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132559AbRDEFQk>; Thu, 5 Apr 2001 01:16:40 -0400
Received: from smtp.mountain.net ([198.77.1.35]:52748 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S131985AbRDEFQ1>;
	Thu, 5 Apr 2001 01:16:27 -0400
Message-ID: <3ACBFF4C.97AA345F@mountain.net>
Date: Thu, 05 Apr 2001 01:14:52 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Race in fs/proc/generic.c:make_inode_number()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The proc_alloc_map bitfield is unprotected by any lock, and
find_first_zero_bit() is not atomic. Concurrent module loading can race
here.

static unsigned char proc_alloc_map[PROC_NDYNAMIC / 8];

static int make_inode_number(void)
{
	int i = find_first_zero_bit((void *) proc_alloc_map, PROC_NDYNAMIC);
	if (i<0 || i>=PROC_NDYNAMIC) 
		return -1;
	set_bit(i, (void *) proc_alloc_map);
	return PROC_DYNAMIC_FIRST + i;
}

Cheers,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
