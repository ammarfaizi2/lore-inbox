Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286916AbSACFoK>; Thu, 3 Jan 2002 00:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286971AbSACFoA>; Thu, 3 Jan 2002 00:44:00 -0500
Received: from mysql.sashanet.com ([209.181.82.108]:22941 "EHLO
	mysql.sashanet.com") by vger.kernel.org with ESMTP
	id <S286916AbSACFnx>; Thu, 3 Jan 2002 00:43:53 -0500
Message-Id: <200201030538.g035ceM31957@mysql.sashanet.com>
Content-Type: text/plain;
  charset="us-ascii"
From: Sasha Pachev <sasha@mysql.com>
Organization: MySQL
To: linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: Suspected bug in shrink_caches()
Date: Wed, 2 Jan 2002 22:38:40 -0700
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik:

I am quite sure there is still a bug in shrink_caches(), at least there was 
one in 2.4.17-rc2. I have not tried later releases, but there is nothing in 
the changelog about the fixes anywhere near that area of the code, so I have 
to assume the problem is still there.

Here is how one can expose the bug:

 - disable kswapd and turn off all swap for simplicity
 - run two applications concurrently, one cache intenstive ( eg find / or 
simply create/initialize/read a large file), and the other RAM-intensive - 
allocate a large block and initialize it

When we get to the point where free memory starts running low, even though we 
may have something like 100 MB of cache, shrink_caches() fails to free up 
enough memory, which triggers the evil oom killer. Obviously, in the above 
situation the correct behaviour is to go on cache diet before considering the 
murders.

-- 
MySQL Development Team
For technical support contracts, visit https://order.mysql.com/
   __  ___     ___ ____  __ 
  /  |/  /_ __/ __/ __ \/ /   Sasha Pachev <sasha@mysql.com>
 / /|_/ / // /\ \/ /_/ / /__  MySQL AB, http://www.mysql.com/
/_/  /_/\_, /___/\___\_\___/  Provo, Utah, USA
       <___/                  
