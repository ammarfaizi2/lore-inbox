Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVCDPBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVCDPBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 10:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbVCDPBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 10:01:34 -0500
Received: from mail.dif.dk ([193.138.115.101]:54147 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262762AbVCDPAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 10:00:01 -0500
Date: Fri, 4 Mar 2005 16:00:56 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Domen Puncer <domen@coderock.org>, linux-kernel@vger.kernel.org,
       samba-technical@lists.samba.org, Luca <kronos@kronoz.cjb.net>
Subject: [fourth patch version] Re: in cifssmb.c add copy_from_user return
 value check and do minor formatting/whitespace cleanups.
In-Reply-To: <OF419BF188.53719CEB-ON87256F73.001B2397-86256F73.001B3EEF@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0503041554240.2794@dragon.hygekrogen.localhost>
References: <OF419BF188.53719CEB-ON87256F73.001B2397-86256F73.001B3EEF@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2004, Steven French wrote:

> 
> I had pushed some whitespace changes yesterday (vi must have gone
> haywire somewhere a month or two ago to get the repeated tabs stuck on
> those two line), not sure if I cought all of them in your patch but will
> check. 
> 
> 
I just checked 2.6.11, and the previous patch does not seem to have made 
it in yet, so I re-cut it against 2.6.11 with one additional cleanup of 
some very long lines.

This patch fixes the whitespace damage, the redundant if (pSMB) checks, 
and the copy_from_user warning, just like the previous versions.

Adding Luca to CC since I see he's submitted a similar patch on LKML for 
just the copy_from_user bit a while back, so I thought he might want to 
follow this thread.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-orig/fs/cifs/cifssmb.c	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.11/fs/cifs/cifssmb.c	2005-03-04 15:49:02.000000000 +0100
@@ -246,7 +246,7 @@ smb_init(int smb_command, int wct, struc
 		return rc;
 
 	*request_buf = cifs_buf_get();
-	if (*request_buf == 0) {
+	if (*request_buf == NULL) {
 		/* BB should we add a retry in here if not a writepage? */
 		return -ENOMEM;
 	}
@@ -409,8 +409,8 @@ CIFSSMBNegotiate(unsigned int xid, struc
 		}
 				
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
+
 	return rc;
 }
 
@@ -523,8 +523,7 @@ CIFSSMBLogoff(const int xid, struct cifs
 			rc = -ESHUTDOWN;
 		}
 	}
-	if (pSMB)
-		cifs_small_buf_release(pSMB);
+	cifs_small_buf_release(pSMB);
 	up(&ses->sesSem);
 
 	/* if session dead then we do not need to do ulogoff,
@@ -579,8 +578,7 @@ DelFileRetry:
         }
 #endif
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto DelFileRetry;
 
@@ -630,10 +628,10 @@ RmDirRetry:
         }
 #endif
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto RmDirRetry;
+
 	return rc;
 }
 
@@ -679,10 +677,10 @@ MkDirRetry:
 		atomic_inc(&tcon->num_mkdirs);
         }
 #endif
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto MkDirRetry;
+
 	return rc;
 }
 
@@ -780,10 +778,10 @@ openRetry:
 		atomic_inc(&tcon->num_opens);
 #endif
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto openRetry;
+
 	return rc;
 }
 
@@ -846,12 +844,10 @@ CIFSSMBRead(const int xid, struct cifsTc
 			    memcpy(*buf,pReadData,data_length);
 		}
 	}
-	if (pSMB) {
-		if(*buf)
-			cifs_buf_release(pSMB);
-		else
-			*buf = (char *)pSMB;
-	}
+	if(*buf)
+		cifs_buf_release(pSMB);
+	else
+		*buf = (char *)pSMB;
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls 
 		since file handle passed in no longer valid */
@@ -895,15 +891,18 @@ CIFSSMBWrite(const int xid, struct cifsT
 		bytes_sent = count;
 	pSMB->DataLengthHigh = 0;
 	pSMB->DataOffset =
-	    cpu_to_le16(offsetof(struct smb_com_write_req,Data) - 4);
-    if(buf)
-	    memcpy(pSMB->Data,buf,bytes_sent);
-	else if(ubuf)
-		copy_from_user(pSMB->Data,ubuf,bytes_sent);
-    else {
-		/* No buffer */
-		if(pSMB)
+		cpu_to_le16(offsetof(struct smb_com_write_req,Data) - 4);
+
+	if (buf) {
+		memcpy(pSMB->Data,buf,bytes_sent);
+	} else if (ubuf) {
+		if (copy_from_user(pSMB->Data,ubuf,bytes_sent)) {
 			cifs_buf_release(pSMB);
+			return -EFAULT;
+		}
+	} else {
+		/* No buffer */
+		cifs_buf_release(pSMB);
 		return -EINVAL;
 	}
 
@@ -921,12 +920,10 @@ CIFSSMBWrite(const int xid, struct cifsT
 	} else
 		*nbytes = le16_to_cpu(pSMBr->Count);
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls 
 		since file handle passed in no longer valid */
-
 	return rc;
 }
 
@@ -946,7 +943,7 @@ int CIFSSMBWrite2(const int xid, struct 
 	rc = small_smb_init(SMB_COM_WRITE_ANDX, 14, tcon, (void **) &pSMB);
 	pSMBr = (WRITE_RSP *)pSMB; /* BB removeme BB */
     
-    if (rc)
+	if (rc)
 		return rc;
 	/* tcon and ses pointer are checked in smb_init */
 	if (tcon->ses->server == NULL)
@@ -980,8 +977,7 @@ int CIFSSMBWrite2(const int xid, struct 
 	} else
 		*nbytes = le16_to_cpu(pSMBr->Count);
 
-	if (pSMB)
-		cifs_small_buf_release(pSMB);
+	cifs_small_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls 
 		since file handle passed in no longer valid */
@@ -1046,8 +1042,7 @@ CIFSSMBLock(const int xid, struct cifsTc
 	if (rc) {
 		cFYI(1, ("Send error in Lock = %d", rc));
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls 
 	since file handle passed in no longer valid */
@@ -1082,9 +1077,7 @@ CIFSSMBClose(const int xid, struct cifsT
 			cERROR(1, ("Send error in Close = %d", rc));
 		}
 	}
-
-	if (pSMB)
-		cifs_small_buf_release(pSMB);
+	cifs_small_buf_release(pSMB);
 
 	/* Since session is dead, file will be closed on server already */
 	if(rc == -EAGAIN)
@@ -1161,9 +1154,7 @@ renameRetry:
 	}
 #endif
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto renameRetry;
 
@@ -1241,12 +1232,11 @@ int CIFSSMBRenameOpenFile(const int xid,
 		atomic_inc(&pTcon->num_t2renames);
 	}
 #endif
-	if (pSMB)
-		cifs_buf_release(pSMB);
+
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls
 		since file handle passed in no longer valid */
-
 	return rc;
 }
 
@@ -1311,9 +1301,7 @@ copyRetry:
 		cFYI(1, ("Send error in copy = %d with %d files copied",
 			rc, le16_to_cpu(pSMBr->CopyCount)));
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto copyRetry;
 
@@ -1403,9 +1391,7 @@ createSymLinkRetry:
 		      rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto createSymLinkRetry;
 
@@ -1492,8 +1478,7 @@ createHardLinkRetry:
 		cFYI(1, ("Send error in SetPathInfo (hard link) = %d", rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto createHardLinkRetry;
 
@@ -1564,8 +1549,7 @@ winCreateHardLinkRetry:
 	if (rc) {
 		cFYI(1, ("Send error in hard link (NT rename) = %d", rc));
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto winCreateHardLinkRetry;
 
@@ -1665,15 +1649,13 @@ querySymLinkRetry:
 	/* just in case so calling code does not go off the end of buffer */
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto querySymLinkRetry;
+
 	return rc;
 }
 
-
-
 int
 CIFSSMBQueryReparseLinkInfo(const int xid, struct cifsTconInfo *tcon,
 			const unsigned char *searchName,
@@ -1749,12 +1731,10 @@ CIFSSMBQueryReparseLinkInfo(const int xi
 			cFYI(1,("readlink result - %s ",symlinkinfo));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls
 		since file handle passed in no longer valid */
-
 	return rc;
 }
 
@@ -1969,10 +1949,10 @@ queryAclRetry:
 				buflen,acl_type,count);
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto queryAclRetry;
+
 	return rc;
 }
 
@@ -1996,7 +1976,8 @@ setAclRetry:
                       (void **) &pSMBr);
 	if (rc)
 		return rc;
-                                                                                                               	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
+
+	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
 			cifs_strtoUCS((wchar_t *) pSMB->FileName, fileName, PATH_MAX
 				/* BB fixme find define for this maxpathcomponent */
@@ -2049,11 +2030,11 @@ setAclRetry:
 	}
 
 setACLerrorExit:
-	if (pSMB)
-		cifs_buf_release(pSMB);
-                                                                                                            	if (rc == -EAGAIN)
+	cifs_buf_release(pSMB);
+	if (rc == -EAGAIN)
 		goto setAclRetry;
-                                                                                                           	return rc;
+	
+	return rc;
 }
 
 #endif
@@ -2133,8 +2114,7 @@ QPathInfoRetry:
 		} else
 		    rc = -ENOMEM;
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QPathInfoRetry;
 
@@ -2217,8 +2197,7 @@ UnixQPathInfoRetry:
 			       sizeof (FILE_UNIX_BASIC_INFO));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto UnixQPathInfoRetry;
 
@@ -2297,8 +2276,7 @@ findUniqueRetry:
 
 		/* BB fill in */
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto findUniqueRetry;
 
@@ -2406,9 +2384,7 @@ findFirstRetry:
 				le16_to_cpu(pSMBr->t2.DataCount));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto findFirstRetry;
 
@@ -2498,8 +2474,7 @@ findFirst2Retry:
 		/* BB Add code to handle unsupported level rc */
 		cFYI(1, ("Error in FindFirst = %d", rc));
 
-		if (pSMB)
-			cifs_buf_release(pSMB);
+		cifs_buf_release(pSMB);
 
 		/* BB eventually could optimize out free and realloc of buf */
 		/*    for this case */
@@ -2533,8 +2508,7 @@ findFirst2Retry:
 /*cFYI(1,("entries in buf %d index_of_last %d",psrch_inf->entries_in_buffer,psrch_inf->index_of_last_entry));  */
 			*pnetfid = parms->SearchHandle;
 		} else {
-			if(pSMB)
-				cifs_buf_release(pSMB);
+			cifs_buf_release(pSMB);
 		}
 	}
 
@@ -2659,7 +2633,7 @@ int CIFSFindNext2(const int xid, struct 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls
 	since file handle passed in no longer valid */
 FNext2_err_exit:
-	if ((rc != 0) && pSMB)
+	if (rc != 0)
 		cifs_buf_release(pSMB);
                                                                                               
 	return rc;
@@ -2763,12 +2737,10 @@ CIFSFindNext(const int xid, struct cifsT
 			memcpy(findData,response_data,le16_to_cpu(pSMBr->t2.DataCount));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls
 		since file handle passed in no longer valid */
-
 	return rc;
 }
 
@@ -2831,11 +2803,10 @@ GetInodeNumberRetry:
 
 /* BB add missing code here */
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-                                                                                                                         
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto GetInodeNumberRetry;
+
 	return rc;
 }
 #endif /* CIFS_EXPERIMENTAL */
@@ -2938,8 +2909,15 @@ getDFSRetry:
 					(8 /* sizeof start of data block */ +
 					data_offset +
 					(char *) &pSMBr->hdr.Protocol); 
-			cFYI(1,("num_referrals: %d dfs flags: 0x%x ... \nfor referral one refer size: 0x%x srv type: 0x%x refer flags: 0x%x ttl: 0x%x",
-				le16_to_cpu(pSMBr->NumberOfReferrals),le16_to_cpu(pSMBr->DFSFlags), le16_to_cpu(referrals->ReferralSize),le16_to_cpu(referrals->ServerType),le16_to_cpu(referrals->ReferralFlags),le16_to_cpu(referrals->TimeToLive)));
+			cFYI(1,("num_referrals: %d dfs flags: 0x%x ... \n"
+				"for referral one refer size: 0x%x srv type: 0x%x "
+				"refer flags: 0x%x ttl: 0x%x",
+				le16_to_cpu(pSMBr->NumberOfReferrals),
+				le16_to_cpu(pSMBr->DFSFlags),
+				le16_to_cpu(referrals->ReferralSize),
+				le16_to_cpu(referrals->ServerType),
+				le16_to_cpu(referrals->ReferralFlags),
+				le16_to_cpu(referrals->TimeToLive)));
 			/* BB This field is actually two bytes in from start of
 			   data block so we could do safety check that DataBlock
 			   begins at address of pSMBr->NumberOfReferrals */
@@ -3002,9 +2980,7 @@ getDFSRetry:
 
 	}
 GetDFSRefExit:
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto getDFSRetry;
 
@@ -3087,9 +3063,7 @@ QFSInfoRetry:
 			      FSData->f_bsize));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QFSInfoRetry;
 
@@ -3157,9 +3131,7 @@ QFSAttributeRetry:
 			       sizeof (FILE_SYSTEM_ATTRIBUTE_INFO));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QFSAttributeRetry;
 
@@ -3228,9 +3200,7 @@ QFSDeviceRetry:
 			       sizeof (FILE_SYSTEM_DEVICE_INFO));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QFSDeviceRetry;
 
@@ -3298,13 +3268,10 @@ QFSUnixRetry:
 			       sizeof (FILE_SYSTEM_UNIX_INFO));
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QFSUnixRetry;
 
-
 	return rc;
 }
 
@@ -3396,9 +3363,7 @@ SetEOFRetry:
 		cFYI(1, ("SetPathInfo (file size) returned %d", rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto SetEOFRetry;
 
@@ -3482,12 +3447,10 @@ CIFSSMBSetFileSize(const int xid, struct
 		      rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 
 	/* Note: On -EAGAIN error only caller can retry on handle based calls 
 		since file handle passed in no longer valid */
-
 	return rc;
 }
 
@@ -3563,9 +3526,7 @@ SetTimesRetry:
 		cFYI(1, ("SetPathInfo (times) returned %d", rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto SetTimesRetry;
 
@@ -3641,9 +3602,7 @@ SetTimesRetryLegacy:
 		cFYI(1, ("SetPathInfo (times legacy) returned %d", rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto SetTimesRetryLegacy;
 
@@ -3742,10 +3701,10 @@ setPermsRetry:
 		cFYI(1, ("SetPathInfo (perms) returned %d", rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto setPermsRetry;
+
 	return rc;
 }
 
@@ -3789,10 +3748,10 @@ int CIFSSMBNotify(const int xid, struct 
 	if (rc) {
 		cFYI(1, ("Error in Notify = %d", rc));
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
-/*		if (rc == -EAGAIN)
-			goto NotifyRetry; */
+	cifs_buf_release(pSMB);
+/*	if (rc == -EAGAIN)
+		goto NotifyRetry; */
+
 	return rc;	
 }
 #ifdef CONFIG_CIFS_XATTR
@@ -3934,8 +3893,7 @@ QAllEAsRetry:
 			}
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QAllEAsRetry;
 
@@ -4082,8 +4040,7 @@ QEARetry:
 			} 
 		}
 	}
-	if (pSMB)
-		cifs_buf_release(pSMB);
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto QEARetry;
 
@@ -4185,9 +4142,7 @@ SetEARetry:
 		cFYI(1, ("SetPathInfo (EA) returned %d", rc));
 	}
 
-	if (pSMB)
-		cifs_buf_release(pSMB);
-
+	cifs_buf_release(pSMB);
 	if (rc == -EAGAIN)
 		goto SetEARetry;
 


