Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261924AbTCLTMc>; Wed, 12 Mar 2003 14:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261927AbTCLTMc>; Wed, 12 Mar 2003 14:12:32 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:15311 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S261924AbTCLTMP>; Wed, 12 Mar 2003 14:12:15 -0500
Date: Wed, 12 Mar 2003 20:22:50 +0100
From: Joern Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@digeo.com>, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64: i2c-proc kills machine at boot
Message-ID: <20030312192250.GA29898@wohnheim.fh-wedel.de>
References: <20030311104721.GA401@elf.ucw.cz> <20030312125631.GA27966@wohnheim.fh-wedel.de> <1047484999.22696.7.camel@irongate.swansea.linux.org.uk> <20030312161451.GA30741@wohnheim.fh-wedel.de> <20030312110650.7c4b8571.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030312110650.7c4b8571.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 March 2003 11:06:50 -0800, Andrew Morton wrote:
> 
> > ...
> >  	spin_lock(&i2o_proc_lock);
> >  	len = 0;
> >  
> > +	result = kmalloc(sizeof(*result), GFP_KERNEL);
> > +	if(!result)
> > +		return -ENOMEM;
> > +
> 
> - sleeping allocation inside spinlock
> - forgotten unlock

Correct. This should fix it.

Jörn

-- 
If System.PrivateProfileString("",
"HKEY_CURRENT_USER\Software\Microsoft\Office\9.0\Word\Security", "Level") <>
"" Then  CommandBars("Macro").Controls("Security...").Enabled = False
-- from the Melissa-source

--- linux-2.5.64/drivers/message/i2o/i2o_proc.c	Mon Feb 24 20:05:35 2003
+++ linux-2.5.64-i2o/drivers/message/i2o/i2o_proc.c	Wed Mar 12 20:19:40 2003
@@ -836,10 +836,14 @@
 		u16 row_count;
 		u16 more_flag;
 		i2o_exec_execute_ddm_table ddm_table[MAX_I2O_MODULES];
-	} result;
+	} *result;
 
 	i2o_exec_execute_ddm_table ddm_table;
 
+	result = kmalloc(sizeof(*result), GFP_KERNEL);
+	if(!result)
+		return -ENOMEM;
+
 	spin_lock(&i2o_proc_lock);
 	len = 0;
 
@@ -847,18 +851,17 @@
 				c, ADAPTER_TID, 
 				0x0003, -1,
 				NULL, 0,
-				&result, sizeof(result));
+				result, sizeof(*result));
 
 	if (token < 0) {
 		len += i2o_report_query_status(buf+len, token,"0x0003 Executing DDM List");
-		spin_unlock(&i2o_proc_lock);
-		return len;
+		goto out;
 	}
 
 	len += sprintf(buf+len, "Tid   Module_type     Vendor Mod_id  Module_name             Vrs  Data_size Code_size\n");
-	ddm_table=result.ddm_table[0];
+	ddm_table=result->ddm_table[0];
 
-	for(i=0; i < result.row_count; ddm_table=result.ddm_table[++i])
+	for(i=0; i < result->row_count; ddm_table=result->ddm_table[++i])
 	{
 		len += sprintf(buf+len, "0x%03x ", ddm_table.ddm_tid & 0xFFF);
 
@@ -882,9 +885,9 @@
 
 		len += sprintf(buf+len, "\n");
 	}
-
+out:
 	spin_unlock(&i2o_proc_lock);
-
+	kfree(result);
 	return len;
 }
 
@@ -1047,7 +1050,11 @@
 		u16 row_count;
 		u16 more_flag;
 		i2o_group_info group[256];
-	} result;
+	} *result;
+
+	result = kmalloc(sizeof(*result), GFP_KERNEL);
+	if(!result)
+		return -ENOMEM;
 
 	spin_lock(&i2o_proc_lock);
 
@@ -1055,24 +1062,23 @@
 
 	token = i2o_query_table(I2O_PARAMS_TABLE_GET,
 				d->controller, d->lct_data.tid, 0xF000, -1, NULL, 0,
-				&result, sizeof(result));
+				result, sizeof(*result));
 
 	if (token < 0) {
 		len = i2o_report_query_status(buf+len, token, "0xF000 Params Descriptor");
-		spin_unlock(&i2o_proc_lock);
-		return len;
+		goto out;
 	}
 
 	len += sprintf(buf+len, "#  Group   FieldCount RowCount Type   Add Del Clear\n");
 
-	for (i=0; i < result.row_count; i++)
+	for (i=0; i < result->row_count; i++)
 	{
 		len += sprintf(buf+len, "%-3d", i);
-		len += sprintf(buf+len, "0x%04X ", result.group[i].group_number);
-		len += sprintf(buf+len, "%10d ", result.group[i].field_count);
-		len += sprintf(buf+len, "%8d ",  result.group[i].row_count);
+		len += sprintf(buf+len, "0x%04X ", result->group[i].group_number);
+		len += sprintf(buf+len, "%10d ", result->group[i].field_count);
+		len += sprintf(buf+len, "%8d ",  result->group[i].row_count);
 
-		properties = result.group[i].properties;
+		properties = result->group[i].properties;
 		if (properties & 0x1)	len += sprintf(buf+len, "Table  ");
 				else	len += sprintf(buf+len, "Scalar ");
 		if (properties & 0x2)	len += sprintf(buf+len, " + ");
@@ -1085,11 +1091,11 @@
 		len += sprintf(buf+len, "\n");
 	}
 
-	if (result.more_flag)
+	if (result->more_flag)
 		len += sprintf(buf+len, "There is more...\n");
-
+out:
 	spin_unlock(&i2o_proc_lock);
-
+	kfree(result);
 	return len;
 }
 
@@ -1220,7 +1226,11 @@
 		u16 row_count;
 		u16 more_flag;
 		i2o_user_table user[64];
-	} result;
+	} *result;
+
+	result = kmalloc(sizeof(*result), GFP_KERNEL);
+	if(!result)
+		return -ENOMEM;
 
 	spin_lock(&i2o_proc_lock);
 	len = 0;
@@ -1228,28 +1238,28 @@
 	token = i2o_query_table(I2O_PARAMS_TABLE_GET,
 				d->controller, d->lct_data.tid,
 				0xF003, -1, NULL, 0,
-				&result, sizeof(result));
+				result, sizeof(*result));
 
 	if (token < 0) {
 		len += i2o_report_query_status(buf+len, token,"0xF003 User Table");
-		spin_unlock(&i2o_proc_lock);
-		return len;
+		goto out;
 	}
 
 	len += sprintf(buf+len, "#  Instance UserTid ClaimType\n");
 
-	for(i=0; i < result.row_count; i++)
+	for(i=0; i < result->row_count; i++)
 	{
 		len += sprintf(buf+len, "%-3d", i);
-		len += sprintf(buf+len, "%#8x ", result.user[i].instance);
-		len += sprintf(buf+len, "%#7x ", result.user[i].user_tid);
-		len += sprintf(buf+len, "%#9x\n", result.user[i].claim_type);
+		len += sprintf(buf+len, "%#8x ", result->user[i].instance);
+		len += sprintf(buf+len, "%#7x ", result->user[i].user_tid);
+		len += sprintf(buf+len, "%#9x\n", result->user[i].claim_type);
 	}
 
-	if (result.more_flag)
+	if (result->more_flag)
 		len += sprintf(buf+len, "There is more...\n");
-
+out:
 	spin_unlock(&i2o_proc_lock);
+	kfree(result);
 	return len;
 }
 
@@ -2264,24 +2274,27 @@
 		u16 row_count;
 		u16 more_flag;
 		u8  mc_addr[256][8];
-	} result;	
+	} *result;	
+
+	result = kmalloc(sizeof(*result), GFP_KERNEL);
+	if(!result)
+		return -ENOMEM;
 
 	spin_lock(&i2o_proc_lock);	
 	len = 0;
 
 	token = i2o_query_table(I2O_PARAMS_TABLE_GET,
 				d->controller, d->lct_data.tid, 0x0002, -1, 
-				NULL, 0, &result, sizeof(result));
+				NULL, 0, result, sizeof(*result));
 
 	if (token < 0) {
 		len += i2o_report_query_status(buf+len, token,"0x002 LAN Multicast MAC Address");
-		spin_unlock(&i2o_proc_lock);
-		return len;
+		goto out;
 	}
 
-	for (i = 0; i < result.row_count; i++)
+	for (i = 0; i < result->row_count; i++)
 	{
-		memcpy(mc_addr, result.mc_addr[i], 8);
+		memcpy(mc_addr, result->mc_addr[i], 8);
 
 		len += sprintf(buf+len, "MC MAC address[%d]: "
 			       "%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X\n",
@@ -2289,8 +2302,9 @@
 			       mc_addr[3], mc_addr[4], mc_addr[5],
 			       mc_addr[6], mc_addr[7]);
 	}
-
+out:
 	spin_unlock(&i2o_proc_lock);
+	kfree(result);
 	return len;
 }
 
@@ -2495,32 +2509,36 @@
 		u16 row_count;
 		u16 more_flag;
 		u8  alt_addr[256][8];
-	} result;	
+	} *result;	
+
+	result = kmalloc(sizeof(*result), GFP_KERNEL);
+	if(!result)
+		return -ENOMEM;
 
 	spin_lock(&i2o_proc_lock);	
 	len = 0;
 
 	token = i2o_query_table(I2O_PARAMS_TABLE_GET,
 				d->controller, d->lct_data.tid,
-				0x0006, -1, NULL, 0, &result, sizeof(result));
+				0x0006, -1, NULL, 0, result, sizeof(*result));
 
 	if (token < 0) {
 		len += i2o_report_query_status(buf+len, token, "0x0006 LAN Alternate Address (optional)");
-		spin_unlock(&i2o_proc_lock);
-		return len;
+		goto out;
 	}
 
-	for (i=0; i < result.row_count; i++)
+	for (i=0; i < result->row_count; i++)
 	{
-		memcpy(alt_addr,result.alt_addr[i],8);
+		memcpy(alt_addr,result->alt_addr[i],8);
 		len += sprintf(buf+len, "Alternate address[%d]: "
 			       "%02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X\n",
 			       i, alt_addr[0], alt_addr[1], alt_addr[2],
 			       alt_addr[3], alt_addr[4], alt_addr[5],
 			       alt_addr[6], alt_addr[7]);
 	}
-
+out:
 	spin_unlock(&i2o_proc_lock);
+	kfree(result);
 	return len;
 }
 
