Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262687AbTCYPj5>; Tue, 25 Mar 2003 10:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262688AbTCYPj5>; Tue, 25 Mar 2003 10:39:57 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46600 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262687AbTCYPj4>; Tue, 25 Mar 2003 10:39:56 -0500
Date: Tue, 25 Mar 2003 15:51:04 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: 2.5.66: task_struct memory leak?
Message-ID: <20030325155104.B24418@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With 2.5.66, I'm seeing what can only be described as a severe memory
leak.  This isn't something that I noticed on 2.5.65 - in fact, I have
several ARM machines happily running 2.5.65.

The leak seems to be centred around the task_struct slab, which seems
to do nothing but continually grow:

bash-2.04# grep task_struct /proc/slabinfo
task_struct         1868   1868    920  467  467    1 :   32   16 :   1868    1916   467    0    0    0   36 :   1509    496    139      0
...
bash-2.04# ps aux | wc -l
     20
bash-2.04# grep task_struct /proc/slabinfo
task_struct         1892   1892    920  473  473    1 :   32   16 :   1892    1956   473    0    0    0   36 :   1519    511    139      0
bash-2.04# grep task_struct /proc/slabinfo 
task_struct         1892   1892    920  473  473    1 :   32   16 :   1892    1957   473    0    0    0   36 :   1519    512    139      0
bash-2.04# grep task_struct /proc/slabinfo 
task_struct         1896   1896    920  474  474    1 :   32   16 :   1896    1961   474    0    0    0   36 :   1519    513    139      0
bash-2.04# grep task_struct /proc/slabinfo 
task_struct         1896   1896    920  474  474    1 :   32   16 :   1896    1961   474    0    0    0   36 :   1520    513    139      0
bash-2.04# grep task_struct /proc/slabinfo 
task_struct         1896   1896    920  474  474    1 :   32   16 :   1896    1961   474    0    0    0   36 :   1521    513    139      0
bash-2.04# grep task_struct /proc/slabinfo 
task_struct         1896   1896    920  474  474    1 :   32   16 :   1896    1961   474    0    0    0   36 :   1522    513    139      0
bash-2.04# grep task_struct /proc/slabinfo 
task_struct         1900   1900    920  475  475    1 :   32   16 :   1900    1965   475    0    0    0   36 :   1522    514    139      0

mm_struct seems to be fairly constant, so these are at least getting freed:
mm_struct             24     36    320    3    3    1 :   32   16 :    120     739    11    2    0    0   44 :   3144     53   3183      5

I'm seeing memory disappear at a rate of 8K / process, which seems to
suggest that the ARM level 1 page tables aren't getting freed either.

Is anyone seeing this type of behaviour on x86?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

