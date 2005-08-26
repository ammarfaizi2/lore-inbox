Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbVHZUIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVHZUIw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 16:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbVHZUIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 16:08:52 -0400
Received: from leviathan.ele.uri.edu ([131.128.51.64]:38542 "EHLO
	leviathan.ele.uri.edu") by vger.kernel.org with ESMTP
	id S1030253AbVHZUIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 16:08:51 -0400
Subject: very weired random io behavior
From: Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: no-dole-available
Date: Fri, 26 Aug 2005 16:08:47 -0400
Message-Id: <1125086927.5549.121.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran a small test program on a 400GB SATA disk connected to Marvel
chip. Using 2.6.11.12 kernel and get this strange behavior.


# iostat -k -p /dev/sdj
Linux 2.6.11.12 (bakstor2u.localdomain)         08/26/2005

avg-cpu:  %user   %nice    %sys %iowait   %idle
           0.11    0.00    6.63   54.75   38.51

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdj               0.00         0.01         0.00         36          0

start with no io. run program with /dev/sdj and count 10240. i supposed
it should only write 40MB data and no read should be generated. but
result is quite weired. there are almost same amount of read and total
size is around 80MB.


# iostat -k -p /dev/sdj
Linux 2.6.11.12 (bakstor2u.localdomain)         08/26/2005

avg-cpu:  %user   %nice    %sys %iowait   %idle
           0.11    0.00    6.48   55.65   37.77

Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
sdj               4.26        11.31        11.47      80476      81640


pls cc to me.

Thanks!

Ming

---------------------------------------------------
#define _LARGEFILE64_SOURCE

#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

int main(int argc, char *argv[])
{
        int n;
        int i, count;
        char *name;
        char buf[4096];
        int fd;

        if (argc != 3) {
                printf("%s name count\n", argv[0]);
                exit(1);
        }
        name = argv[1];
        count = atoi(argv[2]);

        fd = open(name, O_CREAT|O_WRONLY, S_IRWXU);
        for (i = 0; i < count; i++) {
                unsigned long x;

                x = (rand() >> 1) << 1;
                lseek64(fd, x, SEEK_SET);
                write(fd, buf, 4096);
        }
        printf("done\n");
        close(fd);
        return 0;
}


