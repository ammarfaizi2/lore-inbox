Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135843AbRAVXmH>; Mon, 22 Jan 2001 18:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135850AbRAVXlv>; Mon, 22 Jan 2001 18:41:51 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:23377
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S135605AbRAVXkc>; Mon, 22 Jan 2001 18:40:32 -0500
Date: Tue, 23 Jan 2001 00:40:26 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/g_NCR5380.c: check_*_region -> request_*_region (241p9)
Message-ID: <20010123004026.M602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

(I have not been able to find a maintainer for this code.)

The following patch makes drivers/scsi/g_NCR5380.c check the
return code of request_region instead of using check_region.
Ditto for request_mem_region.

It applies cleanly against ac10 and 241p9.

Comments?


--- linux-ac10-clean/drivers/scsi/g_NCR5380.c	Sat Jan 20 15:17:13 2001
+++ linux-ac10/drivers/scsi/g_NCR5380.c	Mon Jan 22 22:49:41 2001
@@ -361,7 +361,7 @@
 	        }
 	    else
 	        for(i=0; ports[i]; i++) {
-	            if ((!check_region(ports[i], 16)) && (inb(ports[i]) == 0xff))
+			if ((inb(ports[i]) == 0xff) && request_region(ports[i], NCR5380_region_size))
 	                break;
 		}
 	    if (ports[i]) {
@@ -379,15 +379,10 @@
 	    } else
 	        continue;
 	}
-
-	request_region(overrides[current_override].NCR5380_map_name,
-					NCR5380_region_size, "ncr5380");
 #else
-	if(check_mem_region(overrides[current_override].NCR5380_map_name,
-		NCR5380_region_size))
+	if(!request_mem_region(overrides[current_override].NCR5380_map_name,
+		NCR5380_region_size, "ncr5380"))
 		continue;
-	request_mem_region(overrides[current_override].NCR5380_map_name,
-					NCR5380_region_size, "ncr5380");
 #endif
 	instance = scsi_register (tpnt, sizeof(struct NCR5380_hostdata));
 	if(instance == NULL)

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Half this game is ninety percent mental.
-Philadelphia Phillies manager Danny Ozark
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
