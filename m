Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317930AbSG2Aox>; Sun, 28 Jul 2002 20:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317928AbSG2Aox>; Sun, 28 Jul 2002 20:44:53 -0400
Received: from [210.78.134.243] ([210.78.134.243]:50949 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S317925AbSG2Aow>;
	Sun, 28 Jul 2002 20:44:52 -0400
Date: Mon, 29 Jul 2002 8:50:5 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: problem with eepro100 NAPI driver
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200207290852736.SM00792@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i applied the latest napi patch for eepro100, but i still met the problem. 
when i tested the 64bytes frame with smartbits, in the beginning both the RX and TX of the system are normal. but after a while,the network card stop to receive and transmit packets .
i checked the proc/ params, and found that when soft_reset_count increased one, the system would stop to receive packets for a while. the phenomenon is just like the congestion problem of the interrupt driver as metioned in the NAPI article.
the code after patched is as follows. at what condition will soft_reset_count increase?  what did the speedo_rx_soft_reset() do? and  is there something  incorrect when dealing with that?  according to the comment,maybe the sp->cur_rx should be dealt.

      if (!(status & RxComplete)) {
         int intr_status;
         unsigned long ioaddr = dev->base_addr;
         unsigned long flags;

         spin_lock_irqsave(&sp->lock,flags);
         intr_status = inw(ioaddr + SCBStatus);
         /* We check receiver state here because if
          * we have to do soft reset,sp->cur_rx should
          * point to an empty entry or something
          * unexpected will happen
          */
         if ((intr_status & 0x3c) != 0x10) {
            if (speedo_debug > 4)
               printk("No resource,reset\n");
            speedo_rx_soft_reset(dev);
            sp->soft_reset_count++;
         }
         spin_unlock_irqrestore(&sp->lock,flags);
         break;
      }


please cc. thanks.

chuanbo zheng
zhengcb@netpower.com.cn


>  I don't know which version you get.The ealier versions do have
>serious problems. The latest one(6.19) on NAPI website works
>well for me,but someone report problem of it too.Since i get no
>environment and time to investigate it,the problem is pending now.
>I will send you the latest patch in case you can't find it in other mail.
>
>zhengchuanbo wrote:
>
>>i tried ehe eepro100 NAPI driver on linux2.4.19. the kernel was compiled successfully. but when i tested the throughput of the system,i met some problem.
>>i tested the system with smartbits. when the frame size is 64bytes, in the beginning the system can receive and transmit packets. but after a while, the network card would not receive and transmit packets any more. 
>>then with frame size bigger than 128bytes, it worked well. the throughput was improved. (but sometimes it also has some problem just like 64bytes frames).
>>so what's the problem? is there something wrong with the driver?
>>please cc. thanks.
>>
>>
>>zhengchuanbo  
>>
>>
>>


