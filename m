Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263553AbREYFy2>; Fri, 25 May 2001 01:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263552AbREYFyS>; Fri, 25 May 2001 01:54:18 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:56537 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263547AbREYFyB>; Fri, 25 May 2001 01:54:01 -0400
Message-Id: <200105250553.f4P5rq427751@smtp1.Stanford.EDU>
From: Praveen Srinivasan <praveens@stanford.edu>
Subject: Re: [PATCH] sd.c - null ptr fixes for 2.4.4
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Reply-To: praveens@stanford.edu
Date: Thu, 24 May 2001 22:55:09 -0700
In-Reply-To: <fa.gqdt9cv.220q9v@ifi.uio.no> <fa.ggtutmv.64ehao@ifi.uio.no>
Organization: Stanford University
User-Agent: KNode/0.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a revised patch. Did you mean "free SRpnt" by "surely you need to 
return the request"? The function returns an int. If that is what you 
meant, our revised patch fixes that.

Thanks,
Praveen Srinivasan and Frederick Akalin


--- ./drivers/scsi/sd.c.old     Sat Feb  3 11:45:55 2001
+++ ./drivers/scsi/sd.c Thu May 24 22:48:12 2001
@@ -731,11 +731,19 @@
         * We need to retry the READ_CAPACITY because a UNIT_ATTENTION is
         * considered a fatal error, and many devices report such an error
         * just after a scsi bus reset.
-        */
-
+        */
        SRpnt = scsi_allocate_request(rscsi_disks[i].device);
 
+       if(SRpnt == NULL) {
+               return i;
+       }
+
        buffer = (unsigned char *) scsi_malloc(512);
+
+       if(buffer == NULL) {
+               scsi_release_request(SRpnt);
+               return i;
+       }
 
        spintime = 0;


Alan Cox wrote:

>> This patch fixes a couple of errors in the scsi driver code (sd.c).
>> 
>> --- ../linux/./drivers/scsi/sd.c     Sat Feb  3 11:45:55 2001
>> +++ ./drivers/scsi/sd.c      Mon May  7 22:09:58 2001
>> @@ -734,8 +734,15 @@
>>  */
>>  
>>  SRpnt = scsi_allocate_request(rscsi_disks[i].device);
>> +    if(SRpnt == NULL) {
>> +      return i;
>> +    }
>>  
>>  buffer = (unsigned char *) scsi_malloc(512);
>> +
>> +    if(buffer == NULL) {
>> +      return i;
> 
> You need to return the request surely
> 
>> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

