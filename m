Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288870AbSBRXDT>; Mon, 18 Feb 2002 18:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288919AbSBRXDK>; Mon, 18 Feb 2002 18:03:10 -0500
Received: from ns.ithnet.com ([217.64.64.10]:32778 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S288870AbSBRXC4>;
	Mon, 18 Feb 2002 18:02:56 -0500
Message-Id: <200202182301.AAA23425@webserver.ithnet.com>
Cc: Jens Axboe <axboe@suse.de>, marcelo@conectiva.com.br,
        Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Date: Tue, 19 Feb 2002 00:01:39 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
In-Reply-To: <OFC7A42817.7DD2C3FB-ON85256B64.00725D00@raleigh.ibm.com>
Content-Transfer-Encoding: 7BIT
Subject: Re: [PATCH] Encountered a Null Pointer Problem on the SCSI Layer
To: "Peter Wong" <wpeter@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: IMHO/0.97.1 (Webmail for Roxen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A while ago, I reported that I encountered a null pointer problem   
> on the SCSI layer when I was testing Mingming Cao's diskio patch    
> "diskio-stat-rq-2414" on 2.4.14.                                    
>                                                                     
> Mingming's patch is at http://sourceforge.net/projects/lse/.        
>                                                                     
> The code in sd_find_queue() that protects against accessing a       
> non-existent device is not correct. After my patch was sent out,    
> Pete Zaitcev of Red Hat identified a similar problem in             
> sd_init_command of the same file.                                   
>                                                                     
>      Let's consider sd_find_queue().                                
>                                                                     
>      If the array pointed by rscsi_disk has been allocated,         
> dpnt cannot be null.                                                
>                                                                     
>      If rscsi_disk has NOT been allocated, dpnt =                   
&rscsi_disks[target]                                                  
> may NOT be null, and it depends on the value of target. Thus,       
> "if (!dpnt)" is not sufficient anyway.                              
>                                                                     
>      You can also look at sd_attach(), in which "if (!dpnt->device)"
is                                                                    
> tested, not "if (!dpnt)".                                           
>                                                                     
>      Please check.                                                  
                                                                      
Are you 100% sure, that there is no case where                        
dpnt==NULL? Because if there is such a possibility, your patch will   
blow up.                                                              
It would be completely safe to check both                             
                                                                      
(!dpnt && !dpnt->device)                                              
                                                                      
Regards,                                                              
Stephan                                                               
                                                                      
                                                                      
>                                                                     
> The following patch is based on the 2.4.18-pre7 code:               
>                                                                     
----------------------------------------------------------------------
-----                                                                 
> --- linux/drivers/scsi/sd.c   Mon Feb 18 13:36:42 2002              
> +++ linux-2.4.17-diskio/drivers/scsi/sd.c Mon Feb 18 13:29:34 2002  
> @@ -279,7 +279,7 @@                                                 
>       target = DEVICE_NR(dev);                                      
>                                                                     
>       dpnt = &rscsi_disks[target];                                  
> -     if (!dpnt)                                                    
> +     if (!dpnt->device)                                            
>             return NULL;      /* No such device */                  
>       return &dpnt->device->request_queue;                          
>  }                                                                  
> @@ -302,7 +302,7 @@                                                 
>                                                                     
>       dpnt = &rscsi_disks[dev];                                     
>       if (devm >= (sd_template.dev_max << 4) ||                     
> -         !dpnt ||                                                  
> +         !dpnt->device ||                                          
>           !dpnt->device->online ||                                  
>           block + SCpnt->request.nr_sectors > sd[devm].nr_sects) {  
>             SCSI_LOG_HLQUEUE(2, printk("Finishing %ld sectors\n",   
SCpnt->request.nr_sectors));                                          
>                                                                     
----------------------------------------------------------------------
-----                                                                 
>                                                                     
> Regards,                                                            
> Peter                                                               
>                                                                     
> Wai Yee Peter Wong                                                  
> IBM Linux Technology Center, Performance Analysis                   
> email: wpeter@us.ibm.com                                            
>                                                                     
> -                                                                   
> To unsubscribe from this list: send the line "unsubscribe           
linux-kernel" in                                                      
> the body of a message to majordomo@vger.kernel.org                  
> More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> Please read the FAQ at  http://www.tux.org/lkml/                    
>                                                                     
