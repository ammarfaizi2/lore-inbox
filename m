Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRKCWxh>; Sat, 3 Nov 2001 17:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275693AbRKCWx2>; Sat, 3 Nov 2001 17:53:28 -0500
Received: from ns.ithnet.com ([217.64.64.10]:45316 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S274862AbRKCWxO>;
	Sat, 3 Nov 2001 17:53:14 -0500
Message-Id: <200111032253.XAA20342@webserver.ithnet.com>
Date: Sat, 03 Nov 2001 23:53:09 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
Cc: groudier@club-internet.fr
Content-Transfer-Encoding: 7BIT
Subject: Adaptec vs Symbios performance
To: linux-kernel@vger.kernel.org
In-Reply-To: <3BE3215A.9000302@google.com>
MIME-Version: 1.0
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Justin, hello Gerard                                            
                                                                      
I am looking currently for reasons for bad behaviour of aic7xxx driver
in an shared interrupt setup and general not-nice behaviour of the    
driver regarding multi-tasking environment.                           
Here is what I found in the code:                                     
                                                                      
/*                                                                    
 * SCSI controller interrupt handler.                                 
 */                                                                   
void                                                                  
ahc_linux_isr(int irq, void *dev_id, struct pt_regs * regs)           
{                                                                     
        struct ahc_softc *ahc;                                        
        struct ahc_cmd *acmd;                                         
        u_long flags;                                                 
                                                                      
        ahc = (struct ahc_softc *) dev_id;                            
        ahc_lock(ahc, &flags);                                        
        ahc_intr(ahc);                                                
        /*                                                            
         * It would be nice to run the device queues from a           
         * bottom half handler, but as there is no way to             
         * dynamically register one, we'll have to postpone           
         * that until we get integrated into the kernel.              
         */                                                           
        ahc_linux_run_device_queues(ahc);                             
        acmd = TAILQ_FIRST(&ahc->platform_data->completeq);           
        TAILQ_INIT(&ahc->platform_data->completeq);                   
        ahc_unlock(ahc, &flags);                                      
        if (acmd != NULL)                                             
                ahc_linux_run_complete_queue(ahc, acmd);              
}                                                                     
                                                                      
This is nice. I cannot read the complete code around it (it is derived
from aic7xxx_linux.c) but if I understand the naming and comments     
correct, some workload is done inside the hardware interrupt (which   
shouldn't), which would very much match my tests showing bad overall  
performance behaviour. Obviously this code is old (read the comment)  
and needs reworking.                                                  
Comments?                                                             
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
