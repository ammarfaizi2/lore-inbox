Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVGIODX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVGIODX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 10:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVGIODX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 10:03:23 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41422 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261415AbVGIODV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 10:03:21 -0400
Date: Sat, 9 Jul 2005 16:03:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjanv@infradead.org>, mlindner@syskonnect.de,
       rroesler@syskonnect.de
Subject: [patch] reduce stack footprint of functions in drivers/net/sk98lin/skgepnmi.c
Message-ID: <20050709140314.GA6786@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this patch reduces the stack footprint of Vpd() from 1018 bytes to 28 
bytes, SkPnmiGetStruct() from 744 bytes to 92 bytes, GetVpdKeyArr() from 
552 bytes to 48 bytes, and General() from 364 bytes to 112 bytes.

build and boot tested. (but i likely did not excercise all the possible 
codepaths affected by this patch)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/drivers/net/sk98lin/skgepnmi.c
===================================================================
--- linux.orig/drivers/net/sk98lin/skgepnmi.c
+++ linux/drivers/net/sk98lin/skgepnmi.c
@@ -722,13 +722,20 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 	unsigned int	InstanceCnt;
 	SK_U32		Instance;
 	unsigned int	TmpLen;
-	char		KeyArr[SK_PNMI_VPD_ENTRIES][SK_PNMI_VPD_KEY_SIZE];
+	char		**KeyArr;
 
 
 	SK_DBG_MSG(pAC, SK_DBGMOD_PNMI, SK_DBGCAT_CTRL,
 		("PNMI: SkPnmiGetStruct: Called, BufLen=%d, NetIndex=%d\n",
 			*pLen, NetIndex));
 
+	KeyArr = kmalloc(SK_PNMI_VPD_ENTRIES*SK_PNMI_VPD_KEY_SIZE, GFP_KERNEL);
+	if (!KeyArr)
+		return (SK_PNMI_ERR_GENERAL);
+
+#define return_free(code) \
+		do { kfree(KeyArr); return (code); } while (0)
+
 	if (*pLen < SK_PNMI_STRUCT_SIZE) {
 
 		if (*pLen >= SK_PNMI_MIN_STRUCT_SIZE) {
@@ -738,14 +745,14 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 		}
 
 		*pLen = SK_PNMI_STRUCT_SIZE;
-		return (SK_PNMI_ERR_TOO_SHORT);
+		return_free (SK_PNMI_ERR_TOO_SHORT);
 	}
 
     /*
      * Check NetIndex
      */
 	if (NetIndex >= pAC->Rlmt.NumNets) {
-		return (SK_PNMI_ERR_UNKNOWN_NET);
+		return_free (SK_PNMI_ERR_UNKNOWN_NET);
 	}
 
 	/* Update statistic */
@@ -756,21 +763,21 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 
 		SK_PNMI_SET_STAT(pBuf, Ret, (SK_U32)(-1));
 		*pLen = SK_PNMI_MIN_STRUCT_SIZE;
-		return (Ret);
+		return_free (Ret);
 	}
 
 	if ((Ret = RlmtUpdate(pAC, IoC, NetIndex)) != SK_PNMI_ERR_OK) {
 
 		SK_PNMI_SET_STAT(pBuf, Ret, (SK_U32)(-1));
 		*pLen = SK_PNMI_MIN_STRUCT_SIZE;
-		return (Ret);
+		return_free (Ret);
 	}
 
 	if ((Ret = SirqUpdate(pAC, IoC)) != SK_PNMI_ERR_OK) {
 
 		SK_PNMI_SET_STAT(pBuf, Ret, (SK_U32)(-1));
 		*pLen = SK_PNMI_MIN_STRUCT_SIZE;
-		return (Ret);
+		return_free (Ret);
 	}
 
 	/*
@@ -792,7 +799,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 		SK_PNMI_CHECKFLAGS("SkPnmiGetStruct: On return");
 		SK_PNMI_SET_STAT(pBuf, Ret, (SK_U32)(-1));
 		*pLen = SK_PNMI_MIN_STRUCT_SIZE;
-		return (SK_PNMI_ERR_GENERAL);
+		return_free (SK_PNMI_ERR_GENERAL);
 	}
 
 	/* Retrieve values */
@@ -848,7 +855,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				SK_PNMI_CHECKFLAGS("SkPnmiGetStruct: On return");
 				SK_PNMI_SET_STAT(pBuf, Ret, DstOffset);
 				*pLen = SK_PNMI_MIN_STRUCT_SIZE;
-				return (Ret);
+				return_free (Ret);
 			}
 		}
 	}
@@ -860,9 +867,11 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 	*pLen = SK_PNMI_STRUCT_SIZE;
 	SK_PNMI_CHECKFLAGS("SkPnmiGetStruct: On return");
 	SK_PNMI_SET_STAT(pBuf, SK_PNMI_ERR_OK, (SK_U32)(-1));
-	return (SK_PNMI_ERR_OK);
+	return_free (SK_PNMI_ERR_OK);
 }
 
+#undef return_free
+
 /*****************************************************************************
  *
  * SkPnmiPreSetStruct - Presets the management database in SK_PNMI_STRUCT_DATA
@@ -3023,8 +3032,8 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 {
 	SK_VPD_STATUS	*pVpdStatus;
 	unsigned int	BufLen;
-	char		Buf[256];
-	char		KeyArr[SK_PNMI_VPD_ENTRIES][SK_PNMI_VPD_KEY_SIZE];
+	char		*Buf;
+	char		**KeyArr;
 	char		KeyStr[SK_PNMI_VPD_KEY_SIZE];
 	unsigned int	KeyNo;
 	unsigned int	Offset;
@@ -3035,13 +3044,25 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 	int		Ret;
 	SK_U32		Val32;
 
+	KeyArr = kmalloc(SK_PNMI_VPD_ENTRIES*SK_PNMI_VPD_KEY_SIZE, GFP_KERNEL);
+	if (!KeyArr)
+		return (SK_PNMI_ERR_GENERAL);
+	Buf = kmalloc(256, GFP_KERNEL);
+	if (!Buf) {
+		kfree(KeyArr);
+		return (SK_PNMI_ERR_GENERAL);
+	}
+
+#define return_free(code) \
+		do { kfree(KeyArr); kfree(Buf); return(code); } while (0)
+
 	/*
 	 * Get array of all currently stored VPD keys
 	 */
 	Ret = GetVpdKeyArr(pAC, IoC, &KeyArr[0][0], sizeof(KeyArr), &KeyNo);
 	if (Ret != SK_PNMI_ERR_OK) {
 		*pLen = 0;
-		return (Ret);
+		return_free (Ret);
 	}
 
 	/*
@@ -3072,13 +3093,13 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			if (Index == KeyNo) {
 
 				*pLen = 0;
-				return (SK_PNMI_ERR_UNKNOWN_INST);
+				return_free (SK_PNMI_ERR_UNKNOWN_INST);
 			}
 		}
 		else if (Instance != 1) {
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_UNKNOWN_INST);
+			return_free (SK_PNMI_ERR_UNKNOWN_INST);
 		}
 	}
 
@@ -3094,7 +3115,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			if (*pLen < sizeof(SK_U32)) {
 
 				*pLen = sizeof(SK_U32);
-				return (SK_PNMI_ERR_TOO_SHORT);
+				return_free (SK_PNMI_ERR_TOO_SHORT);
 			}
 			/* Get number of free bytes */
 			pVpdStatus = VpdStat(pAC, IoC);
@@ -3104,7 +3125,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 					SK_PNMI_ERR017MSG);
 
 				*pLen = 0;
-				return (SK_PNMI_ERR_GENERAL);
+				return_free (SK_PNMI_ERR_GENERAL);
 			}
 			if ((pVpdStatus->vpd_status & VPD_VALID) == 0) {
 
@@ -3112,7 +3133,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 					SK_PNMI_ERR018MSG);
 
 				*pLen = 0;
-				return (SK_PNMI_ERR_GENERAL);
+				return_free (SK_PNMI_ERR_GENERAL);
 			}
 			
 			Val32 = (SK_U32)pVpdStatus->vpd_free_rw;
@@ -3129,7 +3150,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			if (*pLen < Len) {
 
 				*pLen = Len;
-				return (SK_PNMI_ERR_TOO_SHORT);
+				return_free (SK_PNMI_ERR_TOO_SHORT);
 			}
 
 			/* Get value */
@@ -3155,7 +3176,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			if (*pLen < sizeof(SK_U32)) {
 
 				*pLen = sizeof(SK_U32);
-				return (SK_PNMI_ERR_TOO_SHORT);
+				return_free (SK_PNMI_ERR_TOO_SHORT);
 			}
 
 			Val32 = (SK_U32)KeyNo;
@@ -3173,7 +3194,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			if (*pLen < Len) {
 
 				*pLen = Len;
-				return (SK_PNMI_ERR_TOO_SHORT);
+				return_free (SK_PNMI_ERR_TOO_SHORT);
 			}
 
 			/*
@@ -3207,14 +3228,14 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 						SK_PNMI_ERR021,
 						SK_PNMI_ERR021MSG);
 
-					return (SK_PNMI_ERR_GENERAL);
+					return_free (SK_PNMI_ERR_GENERAL);
 				}
 				Offset += BufLen + 1;
 			}
 			if (*pLen < Offset) {
 
 				*pLen = Offset;
-				return (SK_PNMI_ERR_TOO_SHORT);
+				return_free (SK_PNMI_ERR_TOO_SHORT);
 			}
 
 			/*
@@ -3234,7 +3255,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 						SK_PNMI_ERR022MSG);
 
 					*pLen = 0;
-					return (SK_PNMI_ERR_GENERAL);
+					return_free (SK_PNMI_ERR_GENERAL);
 				}
 
 				*(pBuf + Offset) = (char)BufLen;
@@ -3248,7 +3269,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			if (*pLen < LastIndex - FirstIndex) {
 
 				*pLen = LastIndex - FirstIndex;
-				return (SK_PNMI_ERR_TOO_SHORT);
+				return_free (SK_PNMI_ERR_TOO_SHORT);
 			}
 
 			for (Offset = 0, Index = FirstIndex;
@@ -3271,7 +3292,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			if (*pLen < Offset) {
 
 				*pLen = Offset;
-				return (SK_PNMI_ERR_TOO_SHORT);
+				return_free (SK_PNMI_ERR_TOO_SHORT);
 			}
 			SK_MEMSET(pBuf, 0, Offset);
 			*pLen = Offset;
@@ -3282,7 +3303,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				SK_PNMI_ERR023MSG);
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 	}
 	else {
@@ -3297,14 +3318,14 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				Id == OID_SKGE_VPD_ACCESS) {
 
 				*pLen = 0;
-				return (SK_PNMI_ERR_READ_ONLY);
+				return_free (SK_PNMI_ERR_READ_ONLY);
 			}
 
 			SK_ERR_LOG(pAC, SK_ERRCL_SW, SK_PNMI_ERR024,
 				SK_PNMI_ERR024MSG);
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 
 		/*
@@ -3314,7 +3335,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 		if (*pLen < 1) {
 
 			*pLen = 1;
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 
 		/*
@@ -3335,7 +3356,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			if (*pLen < 4) {
 
 				*pLen = 4;
-				return (SK_PNMI_ERR_TOO_SHORT);
+				return_free (SK_PNMI_ERR_TOO_SHORT);
 			}
 			KeyStr[0] = pBuf[1];
 			KeyStr[1] = pBuf[2];
@@ -3348,7 +3369,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			if (!VpdMayWrite(KeyStr)) {
 
 				*pLen = 0;
-				return (SK_PNMI_ERR_BAD_VALUE);
+				return_free (SK_PNMI_ERR_BAD_VALUE);
 			}
 
 			Offset = (int)pBuf[3] & 0xFF;
@@ -3359,7 +3380,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			/* A preset ends here */
 			if (Action == SK_PNMI_PRESET) {
 
-				return (SK_PNMI_ERR_OK);
+				return_free (SK_PNMI_ERR_OK);
 			}
 
 			/* Write the new entry or modify an existing one */
@@ -3367,7 +3388,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			if (Ret == SK_PNMI_VPD_NOWRITE ) {
 
 				*pLen = 0;
-				return (SK_PNMI_ERR_BAD_VALUE);
+				return_free (SK_PNMI_ERR_BAD_VALUE);
 			}
 			else if (Ret != SK_PNMI_VPD_OK) {
 
@@ -3375,7 +3396,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 					SK_PNMI_ERR025MSG);
 
 				*pLen = 0;
-				return (SK_PNMI_ERR_GENERAL);
+				return_free (SK_PNMI_ERR_GENERAL);
 			}
 
 			/*
@@ -3389,7 +3410,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 					SK_PNMI_ERR026MSG);
 
 				*pLen = 0;
-				return (SK_PNMI_ERR_GENERAL);
+				return_free (SK_PNMI_ERR_GENERAL);
 			}
 			break;
 
@@ -3398,12 +3419,12 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			if (*pLen < 3) {
 
 				*pLen = 3;
-				return (SK_PNMI_ERR_TOO_SHORT);
+				return_free (SK_PNMI_ERR_TOO_SHORT);
 			}
 			if (*pLen > 3) {
 
 				*pLen = 0;
-				return (SK_PNMI_ERR_BAD_VALUE);
+				return_free (SK_PNMI_ERR_BAD_VALUE);
 			}
 			KeyStr[0] = pBuf[1];
 			KeyStr[1] = pBuf[2];
@@ -3424,12 +3445,12 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			if (Index == KeyNo) {
 
 				*pLen = 0;
-				return (SK_PNMI_ERR_BAD_VALUE);
+				return_free (SK_PNMI_ERR_BAD_VALUE);
 			}
 
 			if (Action == SK_PNMI_PRESET) {
 
-				return (SK_PNMI_ERR_OK);
+				return_free (SK_PNMI_ERR_OK);
 			}
 
 			/* Ok, you wanted it and you will get it */
@@ -3440,7 +3461,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 					SK_PNMI_ERR027MSG);
 
 				*pLen = 0;
-				return (SK_PNMI_ERR_GENERAL);
+				return_free (SK_PNMI_ERR_GENERAL);
 			}
 
 			/*
@@ -3454,19 +3475,22 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 					SK_PNMI_ERR028MSG);
 
 				*pLen = 0;
-				return (SK_PNMI_ERR_GENERAL);
+				return_free (SK_PNMI_ERR_GENERAL);
 			}
 			break;
 
 		default:
 			*pLen = 0;
-			return (SK_PNMI_ERR_BAD_VALUE);
+			return_free (SK_PNMI_ERR_BAD_VALUE);
 		}
 	}
 
-	return (SK_PNMI_ERR_OK);
+	return_free (SK_PNMI_ERR_OK);
+
 }
 
+#undef return_free
+
 /*****************************************************************************
  *
  * General - OID handler function of various single instance OIDs
@@ -3507,16 +3531,22 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 	SK_U64		Val64RxHwErrs = 0;
 	SK_U64		Val64TxHwErrs = 0;
 	SK_BOOL		Is64BitReq = SK_FALSE;
-	char		Buf[256];
+	char		*Buf;
 	int			MacType;
 
+	Buf = kmalloc(256, GFP_KERNEL);
+	if (!Buf)
+		return (SK_PNMI_ERR_GENERAL);
+
+#define return_free(code) \
+		do { kfree(Buf); return(code); } while (0)
 	/*
 	 * Check instance. We only handle single instance variables.
 	 */
 	if (Instance != (SK_U32)(-1) && Instance != 1) {
 
 		*pLen = 0;
-		return (SK_PNMI_ERR_UNKNOWN_INST);
+		return_free (SK_PNMI_ERR_UNKNOWN_INST);
 	}
 
 	/*
@@ -3525,7 +3555,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 	if (Action != SK_PNMI_GET) {
 
 		*pLen = 0;
-		return (SK_PNMI_ERR_READ_ONLY);
+		return_free (SK_PNMI_ERR_READ_ONLY);
 	}
 	
 	MacType = pAC->GIni.GIMacType;
@@ -3541,7 +3571,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 #ifndef SK_NDIS_64BIT_CTR
 		if (*pLen < sizeof(SK_U32)) {
 			*pLen = sizeof(SK_U32);
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 
 #else /* SK_NDIS_64BIT_CTR */
@@ -3555,7 +3585,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			* if insufficient space is provided
 			*/
 			*pLen = sizeof(SK_U64);
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 
 		Is64BitReq = (*pLen < sizeof(SK_U64)) ? SK_FALSE : SK_TRUE;
@@ -3575,7 +3605,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 		if (*pLen < sizeof(SK_U32)) {
 
 			*pLen = sizeof(SK_U32);
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 		break;
 
@@ -3583,7 +3613,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 		if (*pLen < sizeof(SK_U16)) {
 
 			*pLen = sizeof(SK_U16);
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 		break;
 
@@ -3596,7 +3626,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 		if (*pLen < sizeof(SK_U8)) {
 
 			*pLen = sizeof(SK_U8);
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 		break;
 
@@ -3619,7 +3649,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 		if (*pLen < sizeof(SK_U64)) {
 
 			*pLen = sizeof(SK_U64);
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 		break;
 
@@ -3644,7 +3674,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 		if (Ret != SK_PNMI_ERR_OK) {
 
 			*pLen = 0;
-			return (Ret);
+			return_free (Ret);
 		}
 		pAC->Pnmi.MacUpdatedFlag ++;
 
@@ -3695,7 +3725,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 		if (*pLen < Len) {
 
 			*pLen = Len;
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 		for (Offset = 0, Index = 0; Offset < Len;
 			Offset += sizeof(SK_U32), Index ++) {
@@ -3731,7 +3761,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				SK_PNMI_ERR007MSG);
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 
 		Len = SK_STRLEN(pAC->Pnmi.pDriverDescription) + 1;
@@ -3741,13 +3771,13 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				SK_PNMI_ERR029MSG);
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 
 		if (*pLen < Len) {
 
 			*pLen = Len;
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 		*pBuf = (char)(Len - 1);
 		SK_MEMCPY(pBuf + 1, pAC->Pnmi.pDriverDescription, Len - 1);
@@ -3761,7 +3791,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				SK_PNMI_ERR030MSG);
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 
 		Len = SK_STRLEN(pAC->Pnmi.pDriverVersion) + 1;
@@ -3771,13 +3801,13 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				SK_PNMI_ERR031MSG);
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 
 		if (*pLen < Len) {
 
 			*pLen = Len;
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 		*pBuf = (char)(Len - 1);
 		SK_MEMCPY(pBuf + 1, pAC->Pnmi.pDriverVersion, Len - 1);
@@ -3791,7 +3821,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				SK_PNMI_ERR053MSG);
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 
 		Len = SK_STRLEN(pAC->Pnmi.pDriverReleaseDate) + 1;
@@ -3801,13 +3831,13 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				SK_PNMI_ERR054MSG);
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 
 		if (*pLen < Len) {
 
 			*pLen = Len;
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 		*pBuf = (char)(Len - 1);
 		SK_MEMCPY(pBuf + 1, pAC->Pnmi.pDriverReleaseDate, Len - 1);
@@ -3821,7 +3851,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				SK_PNMI_ERR055MSG);
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 
 		Len = SK_STRLEN(pAC->Pnmi.pDriverFileName) + 1;
@@ -3831,13 +3861,13 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				SK_PNMI_ERR056MSG);
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 
 		if (*pLen < Len) {
 
 			*pLen = Len;
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 		*pBuf = (char)(Len - 1);
 		SK_MEMCPY(pBuf + 1, pAC->Pnmi.pDriverFileName, Len - 1);
@@ -3858,7 +3888,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				SK_PNMI_ERR032MSG);
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 		Len ++;
 		if (Len > SK_PNMI_STRINGLEN1) {
@@ -3867,12 +3897,12 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 				SK_PNMI_ERR033MSG);
 
 			*pLen = 0;
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 		if (*pLen < Len) {
 
 			*pLen = Len;
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 		*pBuf = (char)(Len - 1);
 		SK_MEMCPY(pBuf + 1, Buf, Len - 1);
@@ -3884,7 +3914,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 		if (*pLen < 5) {
 
 			*pLen = 5;
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 		Val8 = (SK_U8)pAC->GIni.GIPciHwRev;
 		pBuf[0] = 4;
@@ -3961,7 +3991,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 		if (*pLen < Len) {
 
 			*pLen = Len;
-			return (SK_PNMI_ERR_TOO_SHORT);
+			return_free (SK_PNMI_ERR_TOO_SHORT);
 		}
 		CopyTrapQueue(pAC, pBuf);
 		*pLen = Len;
@@ -4446,7 +4476,7 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 			SK_PNMI_ERR034MSG);
 
 		*pLen = 0;
-		return (SK_PNMI_ERR_GENERAL);
+		return_free (SK_PNMI_ERR_GENERAL);
 	}
 
 	if (Id == OID_SKGE_RX_HW_ERROR_CTS ||
@@ -4459,9 +4489,11 @@ SK_U32 NetIndex)	/* NetIndex (0..n), in 
 		pAC->Pnmi.MacUpdatedFlag --;
 	}
 
-	return (SK_PNMI_ERR_OK);
+	return_free (SK_PNMI_ERR_OK);
 }
 
+#undef return_free
+
 /*****************************************************************************
  *
  * Rlmt - OID handler function of OID_SKGE_RLMT_XXX single instance.
@@ -6535,12 +6567,18 @@ unsigned int KeyArrLen,	/* Length of arr
 unsigned int *pKeyNo)	/* Number of keys */
 {
 	unsigned int		BufKeysLen = SK_PNMI_VPD_BUFSIZE;
-	char			BufKeys[SK_PNMI_VPD_BUFSIZE];
+	char			*BufKeys;
 	unsigned int		StartOffset;
 	unsigned int		Offset;
 	int			Index;
 	int			Ret;
 
+	BufKeys = kmalloc(SK_PNMI_VPD_BUFSIZE, GFP_KERNEL);
+	if (!BufKeys)
+		return (SK_PNMI_ERR_GENERAL);
+
+#define return_free(code) \
+		do { kfree(BufKeys); return (code); } while (0)
 
 	SK_MEMSET(pKeyArr, 0, KeyArrLen);
 
@@ -6554,12 +6592,12 @@ unsigned int *pKeyNo)	/* Number of keys 
 		SK_ERR_LOG(pAC, SK_ERRCL_SW, SK_PNMI_ERR014,
 			SK_PNMI_ERR014MSG);
 
-		return (SK_PNMI_ERR_GENERAL);
+		return_free (SK_PNMI_ERR_GENERAL);
 	}
 	/* If no keys are available return now */
 	if (*pKeyNo == 0 || BufKeysLen == 0) {
 
-		return (SK_PNMI_ERR_OK);
+		return_free (SK_PNMI_ERR_OK);
 	}
 	/*
 	 * If the key list is too long for us trunc it and give a
@@ -6590,7 +6628,7 @@ unsigned int *pKeyNo)	/* Number of keys 
 
 			SK_ERR_LOG(pAC, SK_ERRCL_SW, SK_PNMI_ERR016,
 				SK_PNMI_ERR016MSG);
-			return (SK_PNMI_ERR_GENERAL);
+			return_free (SK_PNMI_ERR_GENERAL);
 		}
 
 		SK_STRNCPY(pKeyArr + Index * SK_PNMI_VPD_KEY_SIZE,
@@ -6607,9 +6645,11 @@ unsigned int *pKeyNo)	/* Number of keys 
 			&BufKeys[StartOffset], SK_PNMI_VPD_KEY_SIZE);
 	}
 
-	return (SK_PNMI_ERR_OK);
+	return_free (SK_PNMI_ERR_OK);
 }
 
+#undef return_free
+
 /*****************************************************************************
  *
  * SirqUpdate - Let the SIRQ update its internal values
