Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285113AbRLQMqK>; Mon, 17 Dec 2001 07:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285120AbRLQMpv>; Mon, 17 Dec 2001 07:45:51 -0500
Received: from thor.bi.teuto.net ([212.8.197.25]:42248 "HELO thor.bi.teuto.net")
	by vger.kernel.org with SMTP id <S285114AbRLQMpr>;
	Mon, 17 Dec 2001 07:45:47 -0500
Date: Mon, 17 Dec 2001 13:45:26 +0100
From: Jan-Benedict Glaw <jbglaw@microdata-pos.de>
To: linux-kernel@vger.kernel.org
Subject: xchg and GCC's optimisation:-(
Message-ID: <20011217134526.A31801@microdata-pos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I recently posted a patch against 2.2.19 which eliminates most
printk()s by (in short words):

#define printk(format, arg...) do {} while(0)

However, I got trouble using the floppy driver, because
./kernel/dma.c:free_dma() seems to get miscompiled:

void free_dma(unsigned int dmanr)
{
        if (dmanr >= MAX_DMA_CHANNELS) {
                printk("Trying to free DMA%d\n", dmanr);
                return;
        }

        if (xchg(&dma_chan_busy[dmanr].lock, 0) == 0) {
/* ERROR */     printk("Trying to free free DMA%d\n", dmanr);
                return;
        }

} /* free_dma */

Including a real_printk() at the line marked with ERROR will
result in:
00000088 <free_dma>:
  88:   83 ec 0c                sub    $0xc,%esp
  8b:   8b 54 24 10             mov    0x10(%esp,1),%edx
  8f:   83 fa 07                cmp    $0x7,%edx
  92:   77 1e                   ja     b2 <free_dma+0x2a>
  94:   31 c0                   xor    %eax,%eax
  96:   87 04 d5 00 00 00 00    xchg   %eax,0x0(,%edx,8)
  9d:   85 c0                   test   %eax,%eax
  9f:   75 11                   jne    b2 <free_dma+0x2a>
  a1:   83 c4 f8                add    $0xfffffff8,%esp
  a4:   52                      push   %edx
  a5:   68 11 00 00 00          push   $0x11
  aa:   e8 fc ff ff ff          call   ab <free_dma+0x23>
  af:   83 c4 10                add    $0x10,%esp
  b2:   83 c4 0c                add    $0xc,%esp
  b5:   c3                      ret
  b6:   8d 76 00                lea    0x0(%esi),%esi
  b9:   8d bc 27 00 00 00 00    lea    0x0(%edi,1),%edi

...which is fine and contains the needed xchg call. However,
substituting the printk() with "do {} while (0)" above,
the "if" path seems to be completely removed by the optimizer:

00000088 <free_dma>:
  88:   c3                      ret    
  89:   8d b4 26 00 00 00 00    lea    0x0(%esi,1),%esi


I've looked at ./include/asm-i386/system.h which does some black
magic with it, and I don't really understand that. However, the
result is that the xchg gets optimized away, rendering at least
the floppy module unuseable:-(

MfG, JBG

