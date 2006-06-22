Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751667AbWFWAIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWFWAIU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbWFWAIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:08:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:3762 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751667AbWFWAIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:08:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=hySwliVQVg3kZWZgViV5bFh4jR0dn/w/Qx/71uY9cHqCwKrNCEhgDAHr2kWaHqbQtdEaFDUTxVdtuFSu30C6ag5Lcq7VPOYH64Yh45jt23/VWYr/Q0Nx+HlzBL+gu7A7/PUGTUGc2+x6dxUuK3GivcqqmOjEcWviU3cM9o744K8=
Date: Fri, 23 Jun 2006 03:43:50 +0400
From: bash <0x62ash@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: O_SYNC on /dev/sda1 (usb-storage) do not work?
Message-Id: <20060623034350.d15614d3.0x62ash@gmail.com>
Organization: DevNull Tech.
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello All,
Im wanna to write to flash drive synchronously, but i found that this
is not work for me :/

Test example:

#define DEVICE          "/dev/sda1"
#define BLOCK_SIZE      512                 // size of block in bytes
#define FIRST_BLOCK     (190*1024*2+1)      // offset in blocks (190 Mb)
#define DEVICE_SIZE     (122312)            // size in blocks (79,98 Mb)

int blk_write(void *buf, size_t count, size_t offset)
{
    int blk_size = (count / BLOCK_SIZE) + ((count % BLOCK_SIZE > 0) ?
1 : 0); int f;
    f = open(DEVICE, O_WRONLY|O_SYNC);
    if (f < 0) {
        fprintf(stderr, "write(): Cannot open file %s: %s\n", DEVICE,
strerror(errno)); return -1;
    }
    offset += FIRST_BLOCK;
    
    if (lseek(f, offset * BLOCK_SIZE, SEEK_SET) != offset * BLOCK_SIZE)
{ fprintf(stderr, "write(): Cannot lseek at file %s: %s\n", DEVICE,
strerror(errno)); close(f);
        return -1;
    }
    if (write(f, buf, BLOCK_SIZE * blk_size) != BLOCK_SIZE * blk_size) {
        fprintf(stderr, "write(): Cannot write to file %s: %s\n",
DEVICE, strerror(errno)); close(f);
        return -1;
    }

#if 1
    if (fsync(f) == -1)
        fprintf(stderr, "write(): Can't fsync file %s: %s\n", DEVICE,
strerror(errno)); sync();
#endif

    if (close(f)) {
        fprintf(stderr, "write(): Cannot close file %s: %s\n", DEVICE,
strerror(errno));
    }
    return 0;
}


#define BUF_SIZE_IN_BLOCKS 10
#define SIGNATURE "this is %d iteration of write() with buf filled by %c\n"

int main()
{   
    size_t buf_size = BLOCK_SIZE * BUF_SIZE_IN_BLOCKS;
    char *buf = malloc(buf_size);
    char signature[1024];
    int i;

    srandom(time(NULL));
    char fill_char = random () % 27 + 65;   // random char [A-Z]

    printf("fill char is %c\n", fill_char);
    
    for (i = 0; i < 500; i += BUF_SIZE_IN_BLOCKS) {
        sprintf(signature, SIGNATURE, i, fill_char);
        memset(buf, fill_char , buf_size);
        memcpy(buf, signature, strlen(signature));

        if (i % 30 == 0)
            printf("Iteration %d\n", i);
        
        if (blk_write(buf, buf_size, i) == -1) {
            printf("Cant write at this iteration: ");
            printf(signature);
            return -1;
        }
    }
    
    free(buf);
    return 0;
}


So.... im starting this program .... 
$ sudo ./test1 
fill char is D
Iteration 0
Iteration 30
Iteration 60
Iteration 90
write(): Cannot write to file /dev/sda1: Input/output error
Cant write at this iteration: this is 110 iteration of write() with buf
filled by D


After 90 I unpluged flash-drive from system.

So, if all operations of write() is synchronously then write() for
"100" iteration was successfull and completed. But when Im dump flash
(by ``dd'' and ``xxd'' programs) i see that buf for 100 iteration was
no written to drive :/


-- 
Biomechanica Artificial Sabotage Humanoid
