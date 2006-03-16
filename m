Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752316AbWCPQDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbWCPQDp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 11:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbWCPQDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 11:03:45 -0500
Received: from web8406.mail.in.yahoo.com ([202.43.219.154]:3669 "HELO
	web8406.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1752316AbWCPQDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 11:03:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DanqP4XHr6t7XZ2ldVLTsMPZntkcfBqhEPU3cDkgJLX3JiBsjLfSzJNTFA0a13mo3wVC6RYgMHyk5K7HGcmUoeisvjmCwDwwv7CuI8CzHME+vgPY2k/44JXaK680yC6ksEkknwSg/fW8jgdAL6tamnnz3CvynHSoVoQ7IJgzrGQ=  ;
Message-ID: <20060316160337.12684.qmail@web8406.mail.in.yahoo.com>
Date: Thu, 16 Mar 2006 16:03:37 +0000 (GMT)
From: osuv osuv <osuvthebest@yahoo.co.in>
Subject: Invalidating page of a user level process from a device driver
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI ALL,

   I need to invalidate a user process page . To
invalidate the page , i need to get into kernel space
, so i am using
   the ioctl func of a char device driver. I am not
getting the right functions or the right way to
invalidate a page.
   
   
   This is my code .
   
                                 User level process 
				 
#include <stdio.h>
#include <fcntl.h>

#define MAX 3000



int main()
{
	int fd,ch,val,i;
	int *buff;
	

	fd=open("filepte", O_RDWR);
	if (!fd)
       {
		perror("OPEN");
		exit(1);
  	} 
   
	printf("\nThe pid of the process is %d",getpid());
	

        buff=(void *)malloc(sizeof(int)*MAX);         
                          // Declaring the buffer
	
        printf("\n The address of buff[0]is
%x,\n",&buff[0]);

	for (i=0;i<MAX;i++)
	   buff[i]=20;                                       
                   // Accessing the buffer (pages) 
	   
	ioctl(fd,1,&buff[0]);                                
                   // Calling ioctl of the device
driver

	for(i=0;i<MAX;i++)
	   buff[i]=i+1;                                      
                   // Accessing the buffer again
(pages)
	   
	printf("The first element of the buffer is
%d",buff[0]);
			
	close(fd);
	return(0);
}

                                    Kernel code
(Device driver)

				    
		IOCTL FUNCTION
		
   
		
   static int motspk_ioctl(struct inode *inode, struct
file *file,unsigned int cmd, unsigned long arg)
  {
   
              /* The virtual address comes in the
parameter "arg" . I want to invalidate the page
corresponding	 
	                     to the virtual address */
     
      struct vm_area_struct *vma1=NULL;
      pte_t *page_table,pg_pte,res;
      struct page *pgptr=NULL;
    
    
      struct mm_struct* mm;
    
       
      
      mm=current->mm;
      
        
    
      
      printk(KERN_ALERT "The pid of the driver is
%d",current->pid);
      
      printk(KERN_ALERT "Entered IOCTL and the addr is
%x\n",arg);
      
    
      
     
      vma1=find_vma(current->mm,arg);                 
                          // Find the vma          
          
      pg_pte=pfn_pte(page_to_pfn(pgptr),PAGE_SHARED); 
                          // Getting the pte for the
page
          
      pte_clear(current->mm,arg,&pg_pte);             
                          // Clearing pte
        
      flush_tlb_page(vma1,arg);                       
                          // Flushing tlb page
     
     
      return 0;     
    }  
    				    


    Thank u in advance.
    
    
    


		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
